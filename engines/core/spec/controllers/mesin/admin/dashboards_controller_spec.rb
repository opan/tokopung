require 'spec_helper'

module Mesin
  describe Admin::DashboardsController do
    set_engine_routes
    
    context "signed out" do
 
      describe "GET #index" do
        it "does not have a current_user" do
          expect(subject.current_user).to be_nil
        end

        it "redirect the user to login page" do
          get :index
          expect(subject).to redirect_to new_user_session_path
        end
      end

    end # context "signed out"

    context "super admin" do
      login_super_admin 
 
      describe "GET #index" do
        it "has current_user" do 
          expect(subject.current_user).not_to be_nil
        end

        it "has current_user is super admin" do
          expect(subject.current_user.roles.super_admin).to be_valid
        end
  
        it "should get :index" do
          get :index
          expect(response).to be_success
        end

        it "renders :index view" do
          get :index
          expect(response).to render_template :index
        end
      end
    end # context "super admin"

    context "user" do
      login_user
 
      describe "GET #index" do
        it "has current_user" do
          expect(subject.current_user).to be_valid
        end

        it "has current_user is customer/user" do
          expect(subject.current_user.roles.customer).to be_valid
        end

        it "should get :index" do
          get :index 
          expect(response).to be_success
        end

        it "renders :index view" do
          get :index
          expect(response).to render_template :index
        end
      end
    end # context "user"
 
  end
end
