class StaticPagesController < ApplicationController
  def home
    @articles = Article.where(:draft => false).limit(3)
    if Event.upcoming.include_subevents.count > 0
      @events = Event.upcoming.include_subevents.limit(3)
      @events_type = "Upcoming Events"
    elsif Event.finished.include_subevents.count > 0
      @events = Event.finished.include_subevents.limit(3)
      @events_type = "Previous Events"
    else
      @events = []
      @events_type = "No Events Yet"
    end
  end

  def contact
  end

  def feed
    @title = "Developers Connect Philippines"
    @entries = 
      (Event.include_subevents.all + Article.where(draft: false).all)
      .sort_by(&:updated_at).reverse
    @updated = unless @entries.empty?
      @entries.first.updated_at
    else
      DateTime.now
    end
    respond_to do |format|
      format.atom { render :layout => false }
      format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  def calendar
    cal = Icalendar::Calendar.new
    cal.timezone { |tz| tz.tzid = "Asia/Manila" }
    cal.x_wr_calname = "DevCon Calendar of Events"

    Event.all.each do |event_temp|
      url = event_url(event_temp)
      cal.event do |e|
        e.dtstart = event_temp.start_at.strftime("%Y%m%dT%H%M00")
        e.dtend = event_temp.end_at.strftime("%Y%m%dT%H%M00")
        e.dtstamp = event_temp.updated_at.strftime("%Y%m%dT%H%M00")
        e.uid = "#{event_temp.slug}@devcon.ph"
        e.summary = event_temp.name
        e.description = (event_temp.summary || "") + " " + url
        e.ip_class = 'PUBLIC'
        e.url = url
      end
    end
    send_data cal.to_ical, filename: "calendar.ics", type: 'text/calendar', x_sendfile: true
  end
end
