module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = FactoryBot.create(:user)
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
      focus_type = FactoryBot.create(:focus_type)
      @attrs = FactoryBot.attributes_for(:lab)
      @attrs[:focus_type_id] = focus_type.id
    end
  end
end
