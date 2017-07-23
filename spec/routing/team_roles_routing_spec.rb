require "spec_helper"

describe TeamRolesController do
  describe "routing" do

    it "routes to #index" do
      get("/labs/1/team_roles").should route_to("team_roles#index", lab_id: "1")
    end

    it "routes to #new" do
      get("/labs/1/team_roles/new").should route_to("team_roles#new", lab_id: "1")
    end

    it "routes to #show" do
      get("/labs/1/team_roles/1").should route_to("team_roles#show", lab_id: "1", id: "1")
    end

    it "routes to #edit" do
      get("/labs/1/team_roles/1/edit").should route_to("team_roles#edit", lab_id: "1", id: "1")
    end

    it "routes to #create" do
      post("/labs/1/team_roles").should route_to("team_roles#create", lab_id: "1")
    end

    it "routes to #update" do
      put("/labs/1/team_roles/1").should route_to("team_roles#update", lab_id: "1", id: "1")
    end

    it "routes to #destroy" do
      delete("/labs/1/team_roles/1").should route_to("team_roles#destroy", lab_id: "1", id: "1")
    end

  end
end
