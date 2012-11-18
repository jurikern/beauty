class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :employer_id
      t.string  :slug,    null: false, default: ''
      t.string  :logo,    null: false, default: ''
      t.string  :brand,   null: false, default: ''
      t.string  :country, null: false, default: ''
      t.string  :state,   null: false, default: ''
      t.string  :city,    null: false, default: ''
      t.string  :address, null: false, default: ''
      t.string  :phone,   null: false, default: ''
      t.string  :email,   null: false, default: ''
      t.float   :lat,     null: false, default: 0
      t.float   :lng,     null: false, default: 0
      t.boolean :gmaps,   null: false, default: false

      t.timestamps
    end

    add_index :companies, :slug,  unique: true
    add_index :companies, :brand, unique: true
    add_foreign_key :companies, :employers, dependent: :delete
  end
end
