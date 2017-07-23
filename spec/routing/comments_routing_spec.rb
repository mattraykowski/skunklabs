require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #index" do
      get("/labs/1/comments").should route_to("comments#index", lab_id: "1")
    end

    it "routes to #new" do
      get("/labs/1/comments/new").should route_to("comments#new", lab_id: "1")
    end

    it "routes to #show" do
      get("/labs/1/comments/1").should route_to("comments#show", lab_id: "1", id: "1")
    end

    it "routes to #edit" do
      get("/labs/1/comments/1/edit").should route_to("comments#edit", lab_id: "1", id: "1")
    end

    it "routes to #create" do
      post("/labs/1/comments").should route_to("comments#create", lab_id: "1")
    end

    it "routes to #update" do
      put("/labs/1/comments/1").should route_to("comments#update", lab_id: "1", id: "1")
    end

    it "routes to #destroy" do
      delete("/labs/1/comments/1").should route_to("comments#destroy", lab_id: "1", id: "1")
    end

  end
end
