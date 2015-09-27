class CreateHouseSettings < ActiveRecord::Migration
  def change
    create_table :house_settings do |t|
      t.integer :house_id
      t.string :setting_name
      t.string :setting_value

      t.timestamps null: false
    end
  end
end
