require 'spec_helper'

describe VenuesController, :type => :controller do
  before do
    sign_in(Fabricate(:admin))
  end

  let :valid_attributes do
    { :name => "Test location", :latitude => 0, :longitude => 0 }
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "POST 'create'" do
    it "should allow creation of venues" do
      post 'create', :venue => valid_attributes
      expect(response).to redirect_to(Venue.last)
    end
    
    it "should handle errors on creation of venues" do
      post 'create', :venue => valid_attributes.merge(:latitude => nil)
      expect(response).to be_success
    end
  end

  describe "update" do
    before do
      @venue = Fabricate(:venue)
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', :id => @venue.slug
        expect(response).to be_success
      end
    end

    describe "PUT 'update'" do
      it "should allow updating of venues" do
        put :update, :id => @venue.slug, :venue => valid_attributes
        expect(response).to redirect_to(Venue.last)
      end

      it "should handle errors on updating of venues" do
        put :update, :id => @venue.slug, :venue => valid_attributes.merge(:latitude => nil)
        expect(response).to be_success
      end
    end
  end

end
