class AddUserIdLink < ActiveRecord::Migration[6.1]
  def change
    change_table :links do |t|
      t.references :user, foregin_key: true
    end
  end
end
