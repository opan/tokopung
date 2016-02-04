class AddConfirmedAtInEmails < ActiveRecord::Migration
  def up
    add_column :mesin_emails, :confirmed_at, :timestamp
  end

  def down
    remove_column :mesin_emails, :confirmed_at
  end
end
