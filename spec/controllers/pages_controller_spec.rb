require 'spec_helper'

describe PagesController do

  describe "GET 'index'" do
    before(:each) do
      @lab = FactoryBot.create(:lab)
      @comment = FactoryBot.create(:comment, lab: @lab, user: @lab.user, is_update: true)
    end

    it "returns http success" do
      get :index
      expect(response).to be_successful
    end

    it 'should provide newest lab' do
      get :index
      expect(assigns(:newest_lab)).to eq(@lab)
    end

    it 'should provide the most recently updated lab' do
      get :index
      expect(assigns(:latest_lab)).to eq(@lab)

    end
  end

  describe "GET 'recent_updates'" do
    before(:each) do
      @lab = FactoryBot.create(:lab)
      @comment = FactoryBot.create(:comment, lab: @lab, user: @lab.user)
    end

    it 'should return comments' do
      get :recent_updates
      expect(assigns(:recent_updates)).to eq([@comment])
    end
  end

end
