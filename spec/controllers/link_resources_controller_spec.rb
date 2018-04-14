require 'spec_helper'

describe LinkResourcesController do
  describe "GET index" do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
      @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
    end

    it "assigns all link_resources as @link_resources" do
      get :index, {lab_id: @lab.id}
      expect(assigns(:link_resources)).to eq([@link_resource])
    end
  end

  describe "GET show" do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
      @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
    end

    it "assigns the requested link_resource as @link_resource" do
      get :show, {lab_id: @lab.id, id: @link_resource.to_param}
      expect(assigns(:link_resource)).to eq(@link_resource)
    end
  end

  describe "GET new" do
    describe "when authenticated" do
      login_user

      describe "when user is a team member" do
        before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
          @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
        end

        it "assigns a new link_resource as @link_resource" do
          get :new, {lab_id: @lab.id}
          expect(assigns(:link_resource)).to be_a_new(LinkResource)
        end
      end

      describe "when user is not a team member" do
        before(:each) do
          @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
          @lab = FactoryGirl.create(:lab, user: @alt_user)
          @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
        end

        it "should redirect to the lab" do
          get :new, {lab_id: @lab.id}
          expect(response).to redirect_to(@lab)
        end
      end
    end

    describe "when not authenticated" do
      before(:each) do
          @lab = FactoryGirl.create(:lab)
      end
      it "should redirect to login" do
        get :new, {lab_id: @lab.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET edit" do
    describe "when authenticated" do
      login_user

      describe "when user is a team member" do
        before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
          @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
        end

        it "assigns the requested link_resource as @link_resource" do
          get :edit, {lab_id: @lab.id, id: @link_resource.to_param}
          expect(assigns(:link_resource)).to eq(@link_resource)
        end
      end

      describe "when user is not a team member" do
        before(:each) do
          @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
          @lab = FactoryGirl.create(:lab, user: @alt_user)
          @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
        end

        it "should redirect to the lab" do
          get :edit, {lab_id: @lab.id, id: @link_resource.to_param}
          expect(response).to redirect_to(@lab)
        end
      end
    end

    describe "when not authenticated" do
      before(:each) do
          @lab = FactoryGirl.create(:lab)
      end
      it "should redirect to login" do
        get :new, {lab_id: @lab.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST create" do
    describe "when authenticated" do
      login_user

      describe "when user is a team member" do
        describe "with valid params" do
          before(:each) do
            @lab = FactoryGirl.create(:lab, user: @user)
            @attrs = FactoryGirl.attributes_for(:link_resource)
            @attrs.merge!({lab_id: @lab.id})
          end

          it "creates a new LinkResource" do
            expect {
              post :create, {lab_id: @lab.id, link_resource: @attrs}
            }.to change(LinkResource, :count).by(1)
          end

          it "assigns a newly created link_resource as @link_resource" do
            post :create, {lab_id: @lab.id, link_resource: @attrs}
            expect(assigns(:link_resource)).to be_a(LinkResource)
            expect(assigns(:link_resource)).to be_persisted
          end

          it "redirects to the lab" do
            post :create, {lab_id: @lab.id, link_resource: @attrs}
            expect(response).to redirect_to(@lab)
          end
        end

        describe "with invalid params" do
          before(:each) do
            @lab = FactoryGirl.create(:lab, user: @user)
            @attrs = FactoryGirl.attributes_for(:link_resource)
            @attrs.merge!({lab_id: @lab.id})
          end

          it "assigns a newly created but unsaved link_resource as @link_resource" do
            allow_any_instance_of(LinkResource).to receive(:save).and_return(false)
            post :create, {lab_id: @lab.id, link_resource: @attrs}
            expect(assigns(:link_resource)).to be_a_new(LinkResource)
          end

          it "re-renders the 'new' template" do
            allow_any_instance_of(LinkResource).to receive(:save).and_return(false)
            post :create, {lab_id: @lab.id, link_resource: @attrs}
            expect(response).to render_template("new")
          end
        end
      end
    end

    describe "when not authenticated" do
      before(:each) do
        @lab = FactoryGirl.create(:lab)
        @attrs = FactoryGirl.attributes_for(:link_resource)
        @attrs.merge!({lab_id: @lab.id})
      end

      it "should redirect to login" do
        post :create, {lab_id: @lab.id, link_resource: @attrs}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT update" do
    describe "when authenticated" do
      login_user

      describe "when user is a team member" do
        before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
          @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
        end

        describe "with valid params" do
          it "updates the requested link_resource" do
            allow_any_instance_of(LinkResource).to receive(:update).with({ "name" => "test" })
            put :update, {lab_id: @lab.id, id: @link_resource.to_param, link_resource: { "name" => "test" }}
          end

          it "assigns the requested link_resource as @link_resource" do
            put :update, {lab_id: @lab.id, id: @link_resource.to_param, link_resource: { "name" => "test" }}
            expect(assigns(:link_resource)).to eq(@link_resource)
          end

          it "redirects to the lab" do
            put :update, {lab_id: @lab.id, id: @link_resource.to_param, link_resource: { "name" => "test"}}
            expect(response).to redirect_to(@lab)
          end
        end

        describe "with invalid params" do
          it "assigns the link_resource as @link_resource" do
            put :update, {lab_id: @lab.id, id: @link_resource.to_param, link_resource: { "name" => ""}}
            expect(assigns(:link_resource)).to eq(@link_resource)
          end

          it "re-renders the 'edit' template" do
            put :update, {lab_id: @lab.id, id: @link_resource.to_param, link_resource: { "name" => ""}}
            expect(response).to render_template("edit")
          end
        end
      end
    end

    describe "when not authenticated" do
      before(:each) do
        @lab = FactoryGirl.create(:lab)
        @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
      end

      it "should redirect to login" do
        put :update, {lab_id: @lab.id, id: @link_resource.to_param, link_resource: { "name" => "test" }}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE destroy" do
    describe "when authenticated" do
      login_user

      describe "when user is a team member" do
        before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
          @link_resource = FactoryGirl.create(:link_resource, lab: @lab)
        end

        it "destroys the requested link_resource" do
          expect {
            delete :destroy, {lab_id: @lab.id, id: @link_resource.to_param}
          }.to change(LinkResource, :count).by(-1)
        end

        it "redirects to the lab" do
          delete :destroy, {lab_id: @lab.id, id: @link_resource.to_param}
          expect(response).to redirect_to(@lab)
        end
      end

      describe "when user is not a team member" do
      end
    end
  end

end
