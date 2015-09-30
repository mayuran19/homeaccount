class AddTenantIdToHouseAccountSummary < ActiveRecord::Migration
  def change
    add_column :house_account_summaries, :tenant_id, :integer
  end
end
