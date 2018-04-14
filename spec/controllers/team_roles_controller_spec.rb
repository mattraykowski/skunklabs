require 'spec_helper'

describe TeamRolesController do

  describe "GET index" do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
      @team_role = FactoryGirl.create(:team_role, lab: @lab)
    end
    it "assigns all team_roles as @team_roles" do
      get :index, {lab_id: @lab.id}
      expect(assigns(:team_roles)).to eq([@team_role])
    end
  end

  describe "GET show" do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
      @team_role = FactoryGirl.create(:team_role, lab: @lab)
    end

    it "assigns the requested team_role as @team_role" do
      get :show, {lab_id: @lab.id, id: @team_role.to_param}
      expect(assigns(:team_role)).to eq(@team_role)
    end
  end

  describe "GET new" do
    describe "when authenticated" do
      login_user

      describe "when user is a team member" do
        before(:each) do
          @lab = FactoryGirl.create(:lab, user: @user)
          @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @user)
        end

        it "assigns a new team_role as @team_role" do
          get :new, {lab_id: @lab.id}
          expect(assigns(:team_role)).to be_a_new(TeamRole)
        end
      end

      describe "when user is not a team member" do
        before(:each) do
          @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
          @lab = FactoryGirl.create(:lab, user: @alt_user)
          @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @alt_user)
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
          @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @user)
        end

        it "assigns the requested team_role as @team_role" do
          get :edit, {lab_id: @lab.id, id: @team_role.to_param}
          expect(assigns(:team_role)).to eq(@team_role)
        end
      end

      describe "when user is not a team member" do
        before(:each) do
          @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
          @lab = FactoryGirl.create(:lab, user: @alt_user)
          @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @alt_user)
        end

        it "should redirect to the lab" do
          get :edit, {lab_id: @lab.id, id: @team_role.to_param}
          expect(response).to redirect_to(@lab)
        end
      end

    end

    describe "when not authenticated" do
      before(:each) do
          @lab = FactoryGirl.create(:lab)
          @team_role = FactoryGirl.create(:team_role, lab: @lab)
      end
      it "should redirect to login" do
        get :edit, {lab_id: @lab.id, id: @team_role.to_param}
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
            @role_type = FactoryGirl.create(:role_type)
            @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @user)
            @attrs = FactoryGirl.attributes_for(:team_role)
            @attrs.merge!({lab_id: @lab.id, role_type_id: @role_type.id})
          end

          it "creates a new TeamRole" do
            expect {
              post :create, {lab_id: @lab.id, team_role: @attrs}
            }.to change(TeamRole, :count).by(1)
          end

          it "assigns a newly created team_role as @team_role" do
            post :create, {lab_id: @lab.id, team_role: @attrs}
            expect(assigns(:team_role)).to be_a(TeamRole)
            expect(assigns(:team_role)).to be_persisted
          end

          it "redirects to the created team_role" do
            post :create, {lab_id: @lab.id, team_role: @attrs}
            expect(response).to redirect_to(lab_team_roles_path(@lab))
          end
        end

        describe "with invalid params" do
          before(:each) do
            @lab = FactoryGirl.create(:lab, user: @user)
            @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @user)
            @attrs = FactoryGirl.attributes_for(:team_role)
            @attrs.merge!({lab_id: @lab.id})
          end

          it "assigns a newly created but unsaved team_role as @team_role" do
            # Trigger the behavior that occurs when invalid params are submitted
            allow_any_instance_of(TeamRole).to receive(:save).and_return(false)
            post :create, {lab_id: @lab.id, team_role: @attrs}
            expect(assigns(:team_role)).to be_a_new(TeamRole)
          end

          it "re-renders the 'new' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            allow_any_instance_of(TeamRole).to receive(:save).and_return(false)
            post :create, {lab_id: @lab.id, team_role: @attrs}
            expect(response).to render_template("new")
          end
        end
      end

      describe "when user is not a team member" do
        before(:each) do
          @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
          @lab = FactoryGirl.create(:lab, user: @alt_user)
          @role_type = FactoryGirl.create(:role_type)
          @attrs = FactoryGirl.attributes_for(:team_role)
          @attrs.merge!({lab_id: @lab.id, role_type_id: @role_type.id})
        end

        it "should redirect to the lab" do
          post :create, { lab_id: @lab.id, team_role: @attrs }

          expect(response).to redirect_to(@lab)
        end
      end
    end

    describe "when not authenticated" do
      before(:each) do
          @lab = FactoryGirl.create(:lab)
          @attrs = FactoryGirl.attributes_for(:team_role)
          @attrs.merge!({lab_id: @lab.id})
      end

      it "should redirect to login" do
        post :create, { lab_id: @lab.id, team_role: @attrs }

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
          @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @user)
        end

        describe "with valid params" do
          it "updates the requested team_role" do
            # Assuming there are no other team_roles in the database, this
            # specifies that the TeamRole created on the previous line
            # receives the :update_attributes message with whatever params are
            # submitted in the request.
            allow_any_instance_of(TeamRole).to receive(:update).with({ "comment" => "test" })
            put :update, {lab_id: @lab.id, id: @team_role.to_param, team_role: { "comment" => "test" }}
          end

          it "assigns the requested team_role as @team_role" do
            put :update, {lab_id: @lab.id, id: @team_role.to_param, team_role: { "comment" => "test" }}
            expect(assigns(:team_role)).to eq(@team_role)
          end

          it "redirects to the team roles list for the lab" do
            put :update, {lab_id: @lab.id, id: @team_role.to_param, team_role: { "comment" => "test" }}
            expect(response).to redirect_to(lab_team_roles_path(@lab))
          end
        end

        describe "with invalid params" do
          it "assigns the team_role as @team_role" do
            # Trigger the behavior that occurs when invalid params are submitted
            allow_any_instance_of(TeamRole).to receive(:save).and_return(false)
            put :update, {lab_id: @lab.id, id: @team_role.to_param, team_role: { "lab_id" => "invalid value" }}
            expect(assigns(:team_role)).to eq(@team_role)
          end

          it "re-renders the 'edit' template" do
            # Trigger the behavior that occurs when invalid params are submitted
            allow_any_instance_of(TeamRole).to receive(:save).and_return(false)
            put :update, {lab_id: @lab.id, id: @team_role.to_param, team_role: { "lab_id" => "invalid value" }}
            expect(response).to render_template("edit")
          end
        end
      end

      describe "when user is not a team member" do
        before(:each) do
          @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
          @lab = FactoryGirl.create(:lab, user: @alt_user)
          @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @alt_user)
        end

        it "should redirect to the lab" do
          post :update, { lab_id: @lab.id, id: @team_role.id }

          expect(response).to redirect_to(@lab)
        end
      end
    end

    describe "when not authenticated" do
      before(:each) do
        @lab = FactoryGirl.create(:lab)
        @team_role = FactoryGirl.create(:team_role, lab: @lab)
      end

      it "should redirect to login" do
        post :update, { lab_id: @lab.id, id: @team_role.id }

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
          @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @user)
        end

        it "destroys the requested team_role" do
          expect {
            delete :destroy, {lab_id: @lab.id, id: @team_role.to_param}
          }.to change(TeamRole, :count).by(-1)
        end

        it "redirects to the team_roles list" do
          delete :destroy, {lab_id: @lab.id, id: @team_role.to_param}
          expect(response).to redirect_to(lab_team_roles_path(@lab))
        end
      end

      describe "when user is not a team member" do
        before(:each) do
          @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
          @lab = FactoryGirl.create(:lab, user: @alt_user)
          @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @alt_user)
        end

        it "should redirect to the lab" do
          delete :destroy, {lab_id: @lab.id, id: @team_role.to_param}

          expect(response).to redirect_to(@lab)
        end
      end
    end

    describe "when not authenticated" do
      before(:each) do
        @lab = FactoryGirl.create(:lab)
        @team_role = FactoryGirl.create(:team_role, lab: @lab)
      end

      it "should redirect to login" do
        delete :destroy, {lab_id: @lab.id, id: @team_role.to_param}

        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

end
