class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :user_id
      t.integer :company_id
      t.string  :role,    null: false, default: ''
      t.boolean :allowed, null: false, default: false

      t.timestamps
    end

    add_foreign_key :employees, :users,     dependent: :delete
    add_foreign_key :employees, :companies, dependent: :delete
  end
end
