require 'spec_helper'

describe PagesController do

  describe "GET 'index'" do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
      @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user, is_update: true)
    end

    it "returns http success" do
      get :index
      response.should be_success
    end

    it 'should provide newest lab' do
      get :index
      assigns(:newest_lab).should eq(@lab)
    end

    it 'should provide the most recently updated lab' do
      get :index
      assigns(:latest_lab).should eq(@lab)

    end
  end

  describe "GET 'recent_updates'" do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
      @comment = FactoryGirl.create(:comment, lab: @lab, user: @lab.user)
    end

    it 'should return comments' do
      get :recent_updates
      assigns(:recent_updates).should eq([@comment])
    end
  end

end
