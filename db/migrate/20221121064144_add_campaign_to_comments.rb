class AddCampaignToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :campaign,  foreign_key: true
  end
end
