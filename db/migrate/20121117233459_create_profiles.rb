class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name,   null: false, default: ''
      t.string :logo,   null: false, default: ''
      t.string :link,   null: false, default: ''
      t.string :gender, null: false, default: ''

      t.timestamps
    end

    add_foreign_key :profiles, :users, dependent: :delete
  end
end
