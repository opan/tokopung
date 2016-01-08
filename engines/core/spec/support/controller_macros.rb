module ControllerMacros
  def login_super_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @super_admin = create(:role, :super_admin)
      @customer = create(:role, :customer)
      user = create(:user, :valid_email)
      user.confirm!
      sign_in user 
    end 
  end # login_admin

  def set_engine_routes
    before(:each) do
      @routes = Mesin::Core::Engine.routes
    end
    
  end # set_engine_routes
end
