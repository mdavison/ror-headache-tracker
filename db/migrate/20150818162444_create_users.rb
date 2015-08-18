class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, force: :cascade do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest

      t.string :activation_digest
      t.boolean  :activated, default: false
      t.datetime :activated_at

      t.string :reset_digest
      t.datetime :reset_sent_at

      t.boolean :admin, default: false

      t.timestamps null: false
    end
  end
end
