require "spec_helper"

describe LinkResourcesController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/labs/1/link_resources").to route_to("link_resources#index", lab_id: "1")
    end

    it "routes to #new" do
      expect(:get => "/labs/1/link_resources/new").to route_to("link_resources#new", lab_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/labs/1/link_resources/1").to route_to("link_resources#show", lab_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(:get => "/labs/1/link_resources/1/edit").to route_to("link_resources#edit", lab_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(:post => "/labs/1/link_resources").to route_to("link_resources#create", lab_id: "1")
    end

    it "routes to #update" do
      expect(:put => "/labs/1/link_resources/1").to route_to("link_resources#update", lab_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/labs/1/link_resources/1").to route_to("link_resources#destroy", lab_id: "1", id: "1")
    end

  end
end
