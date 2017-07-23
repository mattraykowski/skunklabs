require 'spec_helper'

describe FocusTypesController do
  describe "when authenticated as an admin" do
    login_user
    before(:each) do
      @user.admin = true
      @user.save
    end
    
    describe "GET index" do
      before(:each) { @focus_type = FactoryGirl.create(:focus_type) }
      
      it "assigns all focus_types as @focus_types" do
        get :index, {}
        assigns(:focus_types).should eq([@focus_type])
      end
    end

    describe "GET show" do
      before(:each) { @focus_type = FactoryGirl.create(:focus_type) }
      
      it "assigns the requested focus_type as @focus_type" do
        get :show, {id: @focus_type.to_param}
        assigns(:focus_type).should eq(@focus_type)
      end
    end

    describe "GET new" do
      it "assigns a new focus_type as @focus_type" do
        get :new, {}
        assigns(:focus_type).should be_a_new(FocusType)
      end
    end

    describe "GET edit" do
      before(:each) { @focus_type = FactoryGirl.create(:focus_type) }
      
      it "assigns the requested focus_type as @focus_type" do
        get :edit, {id: @focus_type.to_param}
        assigns(:focus_type).should eq(@focus_type)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new FocusType" do
          expect {
            post :create, {focus_type: FactoryGirl.attributes_for(:focus_type)}
          }.to change(FocusType, :count).by(1)
        end

        it "assigns a newly created focus_type as @focus_type" do
          post :create, {focus_type: FactoryGirl.attributes_for(:focus_type)}
          assigns(:focus_type).should be_a(FocusType)
          assigns(:focus_type).should be_persisted
        end

        it "redirects to the created focus_type" do
          post :create, {focus_type: FactoryGirl.attributes_for(:focus_type)}
          response.should redirect_to(FocusType.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved focus_type as @focus_type" do
          # Trigger the behavior that occurs when invalid params are submitted
          FocusType.any_instance.stub(:save).and_return(false)
          post :create, {focus_type: { "name" => "" }}
          assigns(:focus_type).should be_a_new(FocusType)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          FocusType.any_instance.stub(:save).and_return(false)
          post :create, {focus_type: { "name" => "" }}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      before(:each) { @focus_type = FactoryGirl.create(:focus_type) }
      describe "with valid params" do
        it "updates the requested focus_type" do
          # Assuming there are no other focus_types in the database, this
          # specifies that the FocusType created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          FocusType.any_instance.should_receive(:update).with({ "name" => "MyString" })
          put :update, {id: @focus_type.to_param, focus_type: { "name" => "MyString" }}
        end

        it "assigns the requested focus_type as @focus_type" do
          put :update, {id: @focus_type.to_param, focus_type: { "name" => "MyString" }}
          assigns(:focus_type).should eq(@focus_type)
        end

        it "redirects to the focus_type" do
          put :update, {id: @focus_type.to_param, focus_type: { "name" => "MyString" }}
          response.should redirect_to(@focus_type)
        end
      end

      describe "with invalid params" do
        it "assigns the focus_type as @focus_type" do
          # Trigger the behavior that occurs when invalid params are submitted
          FocusType.any_instance.stub(:save).and_return(false)
          put :update, {id: @focus_type.to_param, focus_type: { "name" => "" }}
          assigns(:focus_type).should eq(@focus_type)
        end

        it "re-renders the 'edit' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          FocusType.any_instance.stub(:save).and_return(false)
          put :update, {id: @focus_type.to_param, focus_type: { "name" => "" }}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      before(:each) { @focus_type = FactoryGirl.create(:focus_type) }
      
      it "destroys the requested focus_type" do
        expect {
          delete :destroy, {id: @focus_type.to_param}
        }.to change(FocusType, :count).by(-1)
      end

      it "redirects to the focus_types list" do
        delete :destroy, {id: @focus_type.to_param}
        response.should redirect_to(focus_types_url)
      end
    end
  end
end
