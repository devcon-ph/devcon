require 'spec_helper'

describe 'Events pages' do

  subject { page }

  describe 'for anonymous users' do
    describe 'in the show page' do

      before do
        @event = Fabricate(:event)
        @event.save
        visit event_path(@event)
      end

      it { should have_page_title @event.name }
      it { should_not have_link 'Edit' }

    end
  end
end
