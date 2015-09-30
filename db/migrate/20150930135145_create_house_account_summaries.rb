class CreateHouseAccountSummaries < ActiveRecord::Migration
  def change
    create_table :house_account_summaries do |t|
      t.integer :house_id
      t.integer :house_account_cycle_id
      t.string :account_item
      t.string :account_item_description
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
