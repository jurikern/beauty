class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :user_id

      t.timestamps
    end

    add_foreign_key :employees, :users, dependent: :delete
  end
end
