class AddCampaignIdToAnnotations < ActiveRecord::Migration
  def change
    add_column :annotations, :campaign_id, :integer
  end
end
