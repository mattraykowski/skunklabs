require "spec_helper"

describe SuggestionStatesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/admin/suggestion_states")).to route_to("suggestion_states#index")
    end

    it "routes to #new" do
      expect(get("/admin/suggestion_states/new")).to route_to("suggestion_states#new")
    end

    it "routes to #show" do
      expect(get("/admin/suggestion_states/1")).to route_to("suggestion_states#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/admin/suggestion_states/1/edit")).to route_to("suggestion_states#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/admin/suggestion_states")).to route_to("suggestion_states#create")
    end

    it "routes to #update" do
      expect(put("/admin/suggestion_states/1")).to route_to("suggestion_states#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/admin/suggestion_states/1")).to route_to("suggestion_states#destroy", :id => "1")
    end

  end
end
