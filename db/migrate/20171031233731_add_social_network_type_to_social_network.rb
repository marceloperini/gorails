class AddSocialNetworkTypeToSocialNetwork < ActiveRecord::Migration[5.1]
  def change
    add_reference :social_networks, :social_network_type, foreign_key: true
  end
end
