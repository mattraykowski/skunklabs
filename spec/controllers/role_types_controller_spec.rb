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
        assigns(:role_types).should eq([@role_type])
      end
    end

    describe "GET show" do
      before(:each) { @role_type = FactoryGirl.create(:role_type) }
      
      it "assigns the requested role_type as @role_type" do
        get :show, {id: @role_type.to_param}
      end
    end

    describe "GET new" do
      it "assigns a new role_type as @role_type" do
        get :new, {}
        assigns(:role_type).should be_a_new(RoleType)
      end
    end

    describe "GET edit" do
      before(:each) { @role_type = FactoryGirl.create(:role_type) }
      
      it "assigns the requested role_type as @role_type" do
        get :edit, {id: @role_type.to_param}
        assigns(:role_type).should eq(@role_type)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new RoleType" do
          expect {
            post :create, {role_type: FactoryGirl.attributes_for(:role_type)}
          }.to change(RoleType, :count).by(1)
        end

        it "assigns a newly created role_type as @role_type" do
          post :create, {role_type: FactoryGirl.attributes_for(:role_type)}
          assigns(:role_type).should be_a(RoleType)
          assigns(:role_type).should be_persisted
        end

        it "redirects to the created role_type" do
          post :create, {role_type: FactoryGirl.attributes_for(:role_type)}
          response.should redirect_to(RoleType.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved role_type as @role_type" do
        # Trigger the behavior that occurs when invalid params are submitted
          RoleType.any_instance.stub(:save).and_return(false)
          post :create, {role_type: { "name" => "" }}
          assigns(:role_type).should be_a_new(RoleType)
        end

        it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
          RoleType.any_instance.stub(:save).and_return(false)
          post :create, {role_type: { "name" => "" }}
          response.should render_template("new")
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
          RoleType.any_instance.should_receive(:update).with({ "name" => "MyString" })
          put :update, {id: @role_type.to_param, role_type: { "name" => "MyString" }}
        end

        it "assigns the requested role_type as @role_type" do
          put :update, {id: @role_type.to_param, role_type: { "name" => "MyString" }}
          assigns(:role_type).should eq(@role_type)
        end

        it "redirects to the role_type" do
          put :update, {id: @role_type.to_param, role_type: { "name" => "MyString" }}
          response.should redirect_to(@role_type)
        end
      end

      describe "with invalid params" do
        it "assigns the role_type as @role_type" do
          # Trigger the behavior that occurs when invalid params are submitted
          RoleType.any_instance.stub(:save).and_return(false)
          put :update, {id: @role_type.to_param, :role_type => { "name" => "" }}
          assigns(:role_type).should eq(@role_type)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          RoleType.any_instance.stub(:save).and_return(false)
          put :update, {id: @role_type.to_param, :role_type => { "name" => "" }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      before(:each) { @role_type = FactoryGirl.create(:role_type) }
      
      it "destroys the requested role_type" do
        expect {
          delete :destroy, {id: @role_type.to_param}
        }.to change(RoleType, :count).by(-1)
      end

      it "redirects to the role_types list" do
        delete :destroy, {id: @role_type.to_param}
        response.should redirect_to(role_types_url)
      end
    end

  end
end
