require "spec_helper"

describe FocusTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/focus_types").should route_to("focus_types#index")
    end

    it "routes to #new" do
      get("/admin/focus_types/new").should route_to("focus_types#new")
    end

    it "routes to #show" do
      get("/admin/focus_types/1").should route_to("focus_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/focus_types/1/edit").should route_to("focus_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/focus_types").should route_to("focus_types#create")
    end

    it "routes to #update" do
      put("/admin/focus_types/1").should route_to("focus_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/focus_types/1").should route_to("focus_types#destroy", :id => "1")
    end

  end
end
