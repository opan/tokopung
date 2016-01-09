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
        it "update profile user" do
          params = {profile_attributes: {username: "opan berhasil"}}
          put :update_profile, id: subject.current_user.id, form_profile: params
          compare_name = "opan berhasil"

          expect(subject.current_user.profile.username).to eql "opan berhasil"  
        end

        it "renders json with status 'success'" do
          params = {profile_attributes: {username: "opan berhasil"}}
          put :update_profile, id: subject.current_user.id, form_profile: params
          compare_name = "opan berhasil"
          @expected_response = {status: "success"}
          @response = JSON.parse(response.body)
          expect(@response["status"]).to eql "success"
        end
        
      end

      context "with invalid data" do
        it "update profile user" do
          params = {profile_attributes: {username: nil}}
          put :update_profile, id: subject.current_user.id, form_profile: params
          subject.current_user.reload
          expect(subject.current_user.profile.username).not_to eql nil  
        end

        it "renders json with status 'fails'" do
          params = {profile_attributes: {username: nil}}
          put :update_profile, id: subject.current_user.id, form_profile: params

          @expected_response = {status: "fails"}
          @response = JSON.parse(response.body)
          expect(@response["status"]).to eql "fails"
        end
      end
    end # describe "PUT #update_profile"



  end
end
