class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.integer :house_id
      t.string :name

      t.timestamps null: false
    end
  end
end
