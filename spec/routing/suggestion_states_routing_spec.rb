require "spec_helper"

describe SuggestionStatesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/suggestion_states").should route_to("suggestion_states#index")
    end

    it "routes to #new" do
      get("/admin/suggestion_states/new").should route_to("suggestion_states#new")
    end

    it "routes to #show" do
      get("/admin/suggestion_states/1").should route_to("suggestion_states#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/suggestion_states/1/edit").should route_to("suggestion_states#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/suggestion_states").should route_to("suggestion_states#create")
    end

    it "routes to #update" do
      put("/admin/suggestion_states/1").should route_to("suggestion_states#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/suggestion_states/1").should route_to("suggestion_states#destroy", :id => "1")
    end

  end
end
