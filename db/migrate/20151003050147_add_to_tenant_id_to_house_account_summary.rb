class AddToTenantIdToHouseAccountSummary < ActiveRecord::Migration
  def change
    add_column :house_account_summaries, :to_tenant_id, :integer
  end
end
