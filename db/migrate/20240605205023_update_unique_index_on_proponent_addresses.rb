class UpdateUniqueIndexOnProponentAddresses < ActiveRecord::Migration[7.0]
  def change
    remove_index :proponent_addresses, name: "index_proponent_addresses_on_proponent_id_and_address_id"
    add_index :proponent_addresses, ["proponent_id", "address_id", "kind"], unique: true, name: "index_proponent_addresses_on_proponent_id_and_details"
  end
end
