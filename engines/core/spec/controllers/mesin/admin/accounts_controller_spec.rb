require 'spec_helper'

module Mesin
  describe Admin::AccountsController, type: :controller do
    set_engine_routes  
    login_super_admin

    describe "GET #index" do
      context "when user success login" do
        it "has current_user" do
          expect(subject.current_user).not_to be_nil
        end

        it "renders view :index" do
          get :index
          expect(response).to render_template :index
        end
      end
    end # describe "GET #index"

    describe "PUT #:id/update_profile" do
      
      context "with valid data" do
        it "success update profile user" do
          params = {profile_attributes: {username: "opan berhasil"}}
          put :update_profile, id: subject.current_user.id, account: params, format: :js
          compare_name = "opan berhasil"
          # expect(response).to render_template "update_profile.js.coffee"
          expect(subject.current_user.profile.username).to eql "opan berhasil"  
        end
 
        it "render update_profile.js.coffee" do 
          params = {profile_attributes: {username: "opan berhasil"}}
          put :update_profile, id: subject.current_user.id, account: params, format: :js
          expect(response).to render_template "update_profile"
        end
        
      end

      context "with invalid data" do
        it "fails update profile user" do
          params = {profile_attributes: {username: nil}}
          put :update_profile, id: subject.current_user.id, account: params, format: :js
          subject.current_user.reload
          expect(subject.current_user.profile.username).not_to eql nil  
        end

        it "render update_profile.js.coffee" do
          params = {profile_attributes: {username: nil}}
          put :update_profile, id: subject.current_user.id, account: params, format: :js

          expect(response).to render_template "update_profile"
        end
      end
    end # describe "PUT #update_profile"



  end
end
