require 'spec_helper'

describe EntitiesController, :type => :controller do
  before do
    sign_in(Fabricate(:admin))
  end

  let :valid_attributes do
    { :name => "Test entity", :type => "school" }
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => Fabricate(:entity).slug
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
    it "should allow creation of entities" do
      post 'create', :entity => valid_attributes
      expect(response).to redirect_to(Entity.last)
    end

    it "should handle errors on creation of entities" do
      post 'create', :entity => valid_attributes.merge(:type => nil)
      expect(response).to be_success
    end
  end

  describe "update" do
    before do
      @entity = Fabricate(:entity)
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', :id => @entity.slug
        expect(response).to be_success
      end
    end

    describe "PUT 'update'" do
      it "should allow updating of entities" do
        put :update, :id => @entity.slug, :entity => valid_attributes
        expect(response).to redirect_to(Entity.last)
      end

      it "should handle errors on updating of entitys" do
        put :update, :id => @entity.slug, :entity => valid_attributes.merge(:type => nil)
        expect(response).to be_success
      end
    end
  end

end
