class AddConfirmedTokenNIsPrimaryInEmails < ActiveRecord::Migration
  def up 
    add_column :mesin_emails, :confirmation_token, :string
    add_column :mesin_emails, :is_primary, :boolean, default: false, null: false
  end


  def down
    remove_column :mesin_emails, :confirmation_token
    remove_column :mesin_emails, :is_primary
  end
end
