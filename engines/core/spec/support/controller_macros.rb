module ControllerMacros
  def login_super_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @superadmin = create(:role, :superadmin)
      @customer = create(:role, :customer)
      
      user = create(:user, :valid_email)
      user.create_profile(username: "super admin")
      sign_in user 
    end 
  end # login_admin

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @superadmin = create(:role, :superadmin)
      @customer = create(:role, :customer)
      admin = create(:super_admin)
      admin.create_profile(username: "super admin")

      user = create(:user, :valid_email)
      user.create_profile(username: "user")
      sign_in user
    end    
  end

  def set_engine_routes
    before(:each) do
      @routes = Mesin::Core::Engine.routes
    end
    
  end # set_engine_routes
end
