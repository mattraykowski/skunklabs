require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/labs/1/comments")).to route_to("comments#index", lab_id: "1")
    end

    it "routes to #new" do
      expect(get("/labs/1/comments/new")).to route_to("comments#new", lab_id: "1")
    end

    it "routes to #show" do
      expect(get("/labs/1/comments/1")).to route_to("comments#show", lab_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get("/labs/1/comments/1/edit")).to route_to("comments#edit", lab_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post("/labs/1/comments")).to route_to("comments#create", lab_id: "1")
    end

    it "routes to #update" do
      expect(put("/labs/1/comments/1")).to route_to("comments#update", lab_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete("/labs/1/comments/1")).to route_to("comments#destroy", lab_id: "1", id: "1")
    end

  end
end
