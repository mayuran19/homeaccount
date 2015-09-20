class CreateRecurringFrequencies < ActiveRecord::Migration
  def change
    create_table :recurring_frequencies do |t|
      t.string :frequency
      t.string :description

      t.timestamps null: false
    end
  end
end
