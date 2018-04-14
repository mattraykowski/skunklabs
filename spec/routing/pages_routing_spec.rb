require "spec_helper"

describe PagesController do
  describe "routing" do
    it "routes to #index" do
      expect(get("/")).to route_to("pages#index")
    end
    
    it "routes to #recent_updates" do
      expect(get("/recent_updates")).to route_to("pages#recent_updates")
    end
    
    it 'should route to #about' do
      expect(get('/pages/about')).to route_to('pages#about')
    end
  end
end