require "spec_helper"

describe PagesController do
  describe "routing" do
    it "routes to #index" do
      get("/").should route_to("pages#index")
    end
    
    it "routes to #recent_updates" do
      get("/recent_updates").should route_to("pages#recent_updates")
    end
    
    it 'should route to #about' do
      get('/pages/about').should route_to('pages#about')
    end
  end
end