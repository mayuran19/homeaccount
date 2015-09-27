class CreateHouseAccountCycles < ActiveRecord::Migration
  def change
    create_table :house_account_cycles do |t|
      t.integer :house_id
      t.date :from_date
      t.date :to_date

      t.timestamps null: false
    end
  end
end
