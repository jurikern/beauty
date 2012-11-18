class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.integer :user_id

      t.timestamps
    end

    add_foreign_key :employers, :users, dependent: :delete
  end
end
