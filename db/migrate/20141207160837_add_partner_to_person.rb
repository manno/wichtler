class AddPartnerToPerson < ActiveRecord::Migration
  def change
    add_column :people, :partner_id, :integer
  end
end
