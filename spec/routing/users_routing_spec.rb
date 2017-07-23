require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/admin/users")).to route_to("users#index")
    end

    it "routes to #noticelist" do
      expect(get('/admin/users/noticelist')).to route_to("users#noticelist")
    end

    it "routes to #edit" do
      expect(get("/admin/users/1/edit")).to route_to("users#edit", id: "1")
    end

    # Member routes for AJAX actions.
    it "routes to #admin" do
      expect(put("/admin/users/1/admin")).to route_to("users#admin", id: "1")
    end

    it "routes to #notices" do
      expect(put("/admin/users/1/notices")).to route_to("users#notices", id: "1")
    end

    it "routes to #team" do
      expect(put("/admin/users/1/team")).to route_to("users#team", id: "1")
    end
  end
end
