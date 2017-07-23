require "spec_helper"

describe RoleTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/role_types").should route_to("role_types#index")
    end

    it "routes to #new" do
      get("/admin/role_types/new").should route_to("role_types#new")
    end

    it "routes to #show" do
      get("/admin/role_types/1").should route_to("role_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/role_types/1/edit").should route_to("role_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/role_types").should route_to("role_types#create")
    end

    it "routes to #update" do
      put("/admin/role_types/1").should route_to("role_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/role_types/1").should route_to("role_types#destroy", :id => "1")
    end

  end
end
