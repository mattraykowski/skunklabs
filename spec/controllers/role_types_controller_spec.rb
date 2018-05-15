require 'spec_helper'

describe RoleTypesController do
  describe "when authenticated as an admin" do
    login_user
    before(:each) do
      @user.admin = true
      @user.save
    end

    describe "GET index" do
      before(:each) { @role_type = FactoryGirl.create(:role_type) }

      it "assigns all role_types as @role_types" do
        get :index, {}
        expect(assigns(:role_types)).to eq([@role_type])
      end
    end

    describe "GET show" do
      before(:each) { @role_type = FactoryGirl.create(:role_type) }

      it "assigns the requested role_type as @role_type" do
        get :show, params: {id: @role_type.to_param}
      end
    end

    describe "GET new" do
      it "assigns a new role_type as @role_type" do
        get :new, {}
        expect(assigns(:role_type)).to be_a_new(RoleType)
      end
    end

    describe "GET edit" do
      before(:each) { @role_type = FactoryGirl.create(:role_type) }

      it "assigns the requested role_type as @role_type" do
        get :edit, params: {id: @role_type.to_param}
        expect(assigns(:role_type)).to eq(@role_type)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new RoleType" do
          expect {
            post :create, params: {role_type: FactoryGirl.attributes_for(:role_type)}
          }.to change(RoleType, :count).by(1)
        end

        it "assigns a newly created role_type as @role_type" do
          post :create, params: {role_type: FactoryGirl.attributes_for(:role_type)}
          expect(assigns(:role_type)).to be_a(RoleType)
          expect(assigns(:role_type)).to be_persisted
        end

        it "redirects to the created role_type" do
          post :create, params: {role_type: FactoryGirl.attributes_for(:role_type)}
          expect(response).to redirect_to(RoleType.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved role_type as @role_type" do
        # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(RoleType).to receive(:save).and_return(false)
          post :create, params: {role_type: { "name" => "" }}
          expect(assigns(:role_type)).to be_a_new(RoleType)
        end

        it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(RoleType).to receive(:save).and_return(false)
          post :create, params: {role_type: { "name" => "" }}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      before(:each) { @role_type = FactoryGirl.create(:role_type) }

      describe "with valid params" do
        it "updates the requested role_type" do
          # Assuming there are no other role_types in the database, this
          # specifies that the RoleType created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          allow_any_instance_of(RoleType).to receive(:update).with({ "name" => "MyString" })
          put :update, params: {id: @role_type.to_param, role_type: { "name" => "MyString" }}
        end

        it "assigns the requested role_type as @role_type" do
          put :update, params: {id: @role_type.to_param, role_type: { "name" => "MyString" }}
          expect(assigns(:role_type)).to eq(@role_type)
        end

        it "redirects to the role_type" do
          put :update, params: {id: @role_type.to_param, role_type: { "name" => "MyString" }}
          expect(response).to redirect_to(@role_type)
        end
      end

      describe "with invalid params" do
        it "assigns the role_type as @role_type" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(RoleType).to receive(:save).and_return(false)
          put :update, params: {id: @role_type.to_param, :role_type => { "name" => "" }}
          expect(assigns(:role_type)).to eq(@role_type)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(RoleType).to receive(:save).and_return(false)
          put :update, params: {id: @role_type.to_param, :role_type => { "name" => "" }}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      before(:each) { @role_type = FactoryGirl.create(:role_type) }

      it "destroys the requested role_type" do
        expect {
          delete :destroy, params: {id: @role_type.to_param}
        }.to change(RoleType, :count).by(-1)
      end

      it "redirects to the role_types list" do
        delete :destroy, params: {id: @role_type.to_param}
        expect(response).to redirect_to(role_types_url)
      end
    end

  end
end
