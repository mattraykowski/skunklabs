require "spec_helper"

describe TeamRolesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/labs/1/team_roles")).to route_to("team_roles#index", lab_id: "1")
    end

    it "routes to #new" do
      expect(get("/labs/1/team_roles/new")).to route_to("team_roles#new", lab_id: "1")
    end

    it "routes to #show" do
      expect(get("/labs/1/team_roles/1")).to route_to("team_roles#show", lab_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get("/labs/1/team_roles/1/edit")).to route_to("team_roles#edit", lab_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post("/labs/1/team_roles")).to route_to("team_roles#create", lab_id: "1")
    end

    it "routes to #update" do
      expect(put("/labs/1/team_roles/1")).to route_to("team_roles#update", lab_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete("/labs/1/team_roles/1")).to route_to("team_roles#destroy", lab_id: "1", id: "1")
    end

  end
end
