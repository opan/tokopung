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

    describe "POST #:id/add_user_emails" do
      context "if email valid" do
        it "success create user email" do
          params = {emails_attributes: [{email: "test@opan.com"}]}
          post :add_user_emails, id: subject.current_user.id, account: params, format: :js

          expect(subject.current_user.emails.where(email: "test@opan.com").exists?).to eql true
        end
      end

      context "if email invalid" do
        it "failed create user email" do
          params = {emails_attributes: [{email: "test@opan"}]}
          post :add_user_emails, id: subject.current_user.id, account: params, format: :js

          expect(subject.current_user.emails.where(email: "test@opan").exists?).to eql false
        end
      end
    end

    describe "DELETE #id/change_user_emails to: delete_user_email" do
      context "if this is last email user have" do
        it "delete user email failed" do
          delete :delete_user_email, id: subject.current_user.emails.first.id, format: :js

          expect(assigns(:status)).to eql "fails"
        end
      end

      context "if this is another email user have " do
        it "delete user email will be success" do
          create_another_email = subject.current_user.emails.create(email: "another@email.com")

          delete :delete_user_email, id: create_another_email.id, format: :js
          expect(assigns(:status)).to eql "success"
        end
      end
    end

    describe "PATCH #id/update_password" do
      context "if old password correct" do
        context "if password and password confirmation match" do
          it "update user password" do
            params = {password: "qwertyui", password_confirmation: "qwertyui"}

            patch :update_password, account: params, id: subject.current_user.id, current_password: "12345678", format: :js
            p assigns(:msg)
            expect(assigns(:msg)).to eql "Password has successfully changed"
          end
        end

        context "if password and password confirmation didn't match" do
          it "failed updating user password" do
            params = {password: "22222", password_confirmation: "qwertyui"}

            patch :update_password, account: params, id: subject.current_user.id, current_password: "12345678", format: :js
            expect(assigns(:msg)).not_to eql "Password has successfully changed"
          end
        end
      
      end

      context "if old password wrong" do
        it "failed updating user password" do
          patch :update_password, current_password: "9999999", id: subject.current_user.id, format: :js

          expect(assigns(:msg)).to eql "Invalid password. Make sure for type correctly."
        end
      end
    end

    describe "DELETE #id/delete_account" do
      context "if current_password password valid" do
        context "if success destroyed user" do
          it "redirect_to index account" do
            delete :delete_account, current_password: "12345678", id: subject.current_user.id

            expect(response).to redirect_to admin_accounts_path
          end

          it " and status is 'success'" do
            delete :delete_account, current_password: "12345678", id: subject.current_user.id

            expect(assigns(:status)).to eql "success"
          end
        end
      end

      context "if current_password password invalid" do
        it "message is \"Invalid password. Make sure for type correctly.\"" do
          delete :delete_account, current_password: "9999", id: subject.current_user.id
          expect(assigns(:msg)).to eql "Invalid password. Make sure for typing correctly."
        end

        it "and redirect_to index account panel " do
          delete :delete_account, current_password: "9999", id: subject.current_user.id
          expect(response).to redirect_to admin_accounts_path
        end
      end
    end

    describe "PATCH #:id/lock_account" do
      context "when current_password is not valid" do
        it "redirect_to admin_accounts_path" do
          patch :lock_account, current_password: "tidakvalid", id: subject.current_user.id
          expect(response).to redirect_to admin_accounts_path
        end

        it "and message is 'Invalid password. Make sure for typing correctly'" do
          patch :lock_account, current_password: "tidakvalid", id: subject.current_user.id
          expect(assigns(:msg)).to eql "Invalid password. Make sure for typing correctly"
        end
      end

      context "when current_password is valid" do
        it "user account is locked" do
          patch :lock_account, current_password: "12345678", id: subject.current_user.id
          expect(subject.current_user.access_locked?).to eql true
        end

        it "send email unlock instructions to user" do
          patch :lock_account, current_password: "12345678", id: subject.current_user.id
          expect(ActionMailer::Base.deliveries.count).to be >= 1
        end

        it "get message 'You've successfully lock your account. Check your email for Unlock Instructions.'" do
          patch :lock_account, current_password: "12345678", id: subject.current_user.id
          expect(assigns(:msg)).to eql "You've successfully lock your account. Check your email for Unlock Instructions."
        end

        it "and redirect_to main_app.root_path" do
          patch :lock_account, current_password: "12345678", id: subject.current_user.id
          expect(response).to redirect_to main_app.root_path
        end
      end
    end

  end
end
