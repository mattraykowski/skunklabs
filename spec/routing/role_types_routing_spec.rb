require "spec_helper"

describe RoleTypesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/admin/role_types")).to route_to("role_types#index")
    end

    it "routes to #new" do
      expect(get("/admin/role_types/new")).to route_to("role_types#new")
    end

    it "routes to #show" do
      expect(get("/admin/role_types/1")).to route_to("role_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/admin/role_types/1/edit")).to route_to("role_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/admin/role_types")).to route_to("role_types#create")
    end

    it "routes to #update" do
      expect(put("/admin/role_types/1")).to route_to("role_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/admin/role_types/1")).to route_to("role_types#destroy", :id => "1")
    end

  end
end
