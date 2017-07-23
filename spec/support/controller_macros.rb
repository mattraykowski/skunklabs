module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
  end

  def login_specific_user(user)
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end
  end

  def valid_attribues_for_lab
    before(:each) do
      focus_type = FactoryGirl.create(:focus_type)
      @attrs = FactoryGirl.attributes_for(:lab)
      @attrs[:focus_type_id] = focus_type.id
    end
  end
end
