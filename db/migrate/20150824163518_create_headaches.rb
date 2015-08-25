class CreateHeadaches < ActiveRecord::Migration
  def change
    create_table :headaches do |t|
      t.date :headache_date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :headaches, [:user_id, :headache_date]
  end
end
