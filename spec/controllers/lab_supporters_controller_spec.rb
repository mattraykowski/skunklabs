require 'spec_helper'

describe LabSupportersController do
  describe "GET index" do
    before(:each) do
      @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
      @alt_user2 = FactoryGirl.create(:user, email: 'altuser2@example.com', login: 'altuser2')
      @lab = FactoryGirl.create(:lab, user: @alt_user)
      @lab_supporter = FactoryGirl.create(:lab_supporter, lab: @lab, user: @alt_user2)
    end

    it "assigns all lab_supporters as @lab_supporters" do
      get :supporters, params: {lab_id: @lab.id}
      expect(assigns(:lab_supporters)).to eq([@lab_supporter])
    end
  end

  describe 'when not authenticated' do
    before(:each) do
      @lab = FactoryGirl.create(:lab)
    end

    describe 'GET support' do
      it 'should redirect to login' do
        get :support, params: {lab_id: 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe 'GET unsupport' do
      it 'should redirect to login' do
        get :unsupport, params: {lab_id: 1}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'when authenticated' do
    login_user

    describe 'when user is lab member' do
      before(:each) do
        # Create a lab owned by another user
        @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
        @lab = FactoryGirl.create(:lab, user: @alt_user)

        # And add the current user to the lab team.
        @team_role = FactoryGirl.create(:team_role, lab: @lab, user: @user)
      end

      describe 'GET support' do
        it 'should redirect to the lab' do
          get :support, params: {lab_id: 1}
          expect(response).to redirect_to(@lab)
        end

        it 'should not add support' do
          expect {
            get :support, params: {lab_id: 1}
          }.to change(LabSupporter, :count).by(0)
        end
      end
      describe 'GET unsupport' do
        it 'should redirect to the lab' do
          get :unsupport, params: {lab_id: 1}
          expect(response).to redirect_to(@lab)
        end

        describe 'when supporting' do
          before(:each) { FactoryGirl.create(:lab_supporter, lab: @lab, user: @user)}
          it 'should remove support' do
            expect {
              get :unsupport, params: {lab_id: 1}
            }.to change(LabSupporter, :count).by(-1)
          end
        end
      end
    end

    describe 'when user is not lab member' do
      before(:each) do
        # Create a lab owned by another user
        @alt_user = FactoryGirl.create(:user, email: 'altuser@example.com', login: 'altuser')
        @lab = FactoryGirl.create(:lab, user: @alt_user)
      end

      describe 'GET support' do
        it 'should redirect to the lab' do
          get :support, params: {lab_id: 1}
          expect(response).to redirect_to(@lab)
        end

        it 'should not add support' do
          expect {
            get :support, params: {lab_id: 1}
          }.to change(LabSupporter, :count).by(1)
        end
      end
      describe 'GET unsupport' do
        before(:each) { FactoryGirl.create(:lab_supporter, lab: @lab, user: @user)}

        it 'should redirect to the lab' do
          get :unsupport, params: {lab_id: 1}
          expect(response).to redirect_to(@lab)
        end

        it 'should remove support' do
          expect {
            get :unsupport, params: {lab_id: 1}
          }.to change(LabSupporter, :count).by(-1)
        end
      end
    end
  end
  #
  # # This should return the minimal set of attributes required to create a valid
  # # LabSupporter. As you add validations to LabSupporter, be sure to
  # # adjust the attributes here as well.
  # let(:valid_attributes) {
  #   skip("Add a hash of attributes valid for your model")
  # }
  #
  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }
  #
  # # This should return the minimal set of values that should be in the session
  # # in order to pass any filters (e.g. authentication) defined in
  # # LabSupportersController. Be sure to keep this updated too.
  # let(:valid_session) { {} }
  #
  # describe "GET index" do
  #   it "assigns all lab_supporters as @lab_supporters" do
  #     lab_supporter = LabSupporter.create! valid_attributes
  #     get :index, {}, valid_session
  #     expect(assigns(:lab_supporters)).to eq([lab_supporter])
  #   end
  # end
  #
  # describe "GET show" do
  #   it "assigns the requested lab_supporter as @lab_supporter" do
  #     lab_supporter = LabSupporter.create! valid_attributes
  #     get :show, {:id => lab_supporter.to_param}, valid_session
  #     expect(assigns(:lab_supporter)).to eq(lab_supporter)
  #   end
  # end
  #
  # describe "GET new" do
  #   it "assigns a new lab_supporter as @lab_supporter" do
  #     get :new, {}, valid_session
  #     expect(assigns(:lab_supporter)).to be_a_new(LabSupporter)
  #   end
  # end
  #
  # describe "GET edit" do
  #   it "assigns the requested lab_supporter as @lab_supporter" do
  #     lab_supporter = LabSupporter.create! valid_attributes
  #     get :edit, {:id => lab_supporter.to_param}, valid_session
  #     expect(assigns(:lab_supporter)).to eq(lab_supporter)
  #   end
  # end
  #
  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new LabSupporter" do
  #       expect {
  #         post :create, {:lab_supporter => valid_attributes}, valid_session
  #       }.to change(LabSupporter, :count).by(1)
  #     end
  #
  #     it "assigns a newly created lab_supporter as @lab_supporter" do
  #       post :create, {:lab_supporter => valid_attributes}, valid_session
  #       expect(assigns(:lab_supporter)).to be_a(LabSupporter)
  #       expect(assigns(:lab_supporter)).to be_persisted
  #     end
  #
  #     it "redirects to the created lab_supporter" do
  #       post :create, {:lab_supporter => valid_attributes}, valid_session
  #       expect(response).to redirect_to(LabSupporter.last)
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved lab_supporter as @lab_supporter" do
  #       post :create, {:lab_supporter => invalid_attributes}, valid_session
  #       expect(assigns(:lab_supporter)).to be_a_new(LabSupporter)
  #     end
  #
  #     it "re-renders the 'new' template" do
  #       post :create, {:lab_supporter => invalid_attributes}, valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end
  #
  # describe "PUT update" do
  #   describe "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }
  #
  #     it "updates the requested lab_supporter" do
  #       lab_supporter = LabSupporter.create! valid_attributes
  #       put :update, {:id => lab_supporter.to_param, :lab_supporter => new_attributes}, valid_session
  #       lab_supporter.reload
  #       skip("Add assertions for updated state")
  #     end
  #
  #     it "assigns the requested lab_supporter as @lab_supporter" do
  #       lab_supporter = LabSupporter.create! valid_attributes
  #       put :update, {:id => lab_supporter.to_param, :lab_supporter => valid_attributes}, valid_session
  #       expect(assigns(:lab_supporter)).to eq(lab_supporter)
  #     end
  #
  #     it "redirects to the lab_supporter" do
  #       lab_supporter = LabSupporter.create! valid_attributes
  #       put :update, {:id => lab_supporter.to_param, :lab_supporter => valid_attributes}, valid_session
  #       expect(response).to redirect_to(lab_supporter)
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns the lab_supporter as @lab_supporter" do
  #       lab_supporter = LabSupporter.create! valid_attributes
  #       put :update, {:id => lab_supporter.to_param, :lab_supporter => invalid_attributes}, valid_session
  #       expect(assigns(:lab_supporter)).to eq(lab_supporter)
  #     end
  #
  #     it "re-renders the 'edit' template" do
  #       lab_supporter = LabSupporter.create! valid_attributes
  #       put :update, {:id => lab_supporter.to_param, :lab_supporter => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end
  #
  # describe "DELETE destroy" do
  #   it "destroys the requested lab_supporter" do
  #     lab_supporter = LabSupporter.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => lab_supporter.to_param}, valid_session
  #     }.to change(LabSupporter, :count).by(-1)
  #   end
  #
  #   it "redirects to the lab_supporters list" do
  #     lab_supporter = LabSupporter.create! valid_attributes
  #     delete :destroy, {:id => lab_supporter.to_param}, valid_session
  #     expect(response).to redirect_to(lab_supporters_url)
  #   end
  # end

end
