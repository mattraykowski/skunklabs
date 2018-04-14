require "spec_helper"

describe FocusTypesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/admin/focus_types")).to route_to("focus_types#index")
    end

    it "routes to #new" do
      expect(get("/admin/focus_types/new")).to route_to("focus_types#new")
    end

    it "routes to #show" do
      expect(get("/admin/focus_types/1")).to route_to("focus_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/admin/focus_types/1/edit")).to route_to("focus_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/admin/focus_types")).to route_to("focus_types#create")
    end

    it "routes to #update" do
      expect(put("/admin/focus_types/1")).to route_to("focus_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/admin/focus_types/1")).to route_to("focus_types#destroy", :id => "1")
    end

  end
end
