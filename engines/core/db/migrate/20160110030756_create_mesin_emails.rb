class CreateMesinEmails < ActiveRecord::Migration
  def up
    create_table :mesin_emails do |t|
      t.string :email, limit: 100, null: false
      t.belongs_to :user, index: true
      t.string :label, limit: 20
      t.timestamps null: false
    end

    add_index :mesin_emails, :email, unique: true
    add_foreign_key :mesin_emails, :mesin_users, column: :user_id
  end

  def down
    drop_table :mesin_emails
    
  end
end
