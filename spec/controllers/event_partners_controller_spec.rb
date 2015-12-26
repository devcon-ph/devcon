require 'spec_helper'

describe EventPartnersController, :type => :controller do
  before do
    sign_in(Fabricate(:admin))
    @event = Fabricate(:event)
    @entity = Fabricate(:entity)
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new', :event_id => @event.slug
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    it "should allow creation of entities" do
      post 'create', :event_id => @event.slug, :event_partner => { :entity_id => @entity.id, :role => "test" }
      expect(response).to redirect_to(@event)
    end

    it "should handle errors on creation of entities" do
      post 'create', :event_id => @event.slug, :event_partner => { :entity_id => nil }
      expect(response).to be_success
    end
  end

  describe "update" do
    before do
      @event_partner = Fabricate(:event_partner, :entity => @entity, :event => @event)
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', :event_id => @event.slug, :id => @event_partner.id
        expect(response).to be_success
      end
    end

    describe "PUT 'update'" do
      it "should allow updating of entities" do
        put :update, :event_id => @event.slug, :id => @event_partner.id, :event_partner => { :entity_id => @entity.id, :role => "test" }
        expect(response).to redirect_to(@event)
      end

      it "should handle errors on updating of entitys" do
        put :update, :event_id => @event.slug, :id => @event_partner.id, :event_partner => { :entity_id => nil }
        expect(response).to be_success
      end
    end
  end

end
