class CreateProponentAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :proponent_addresses do |t|
      t.references :proponent, null: false, foreign_key: true, type: :uuid
      t.references :address, null: false, foreign_key: true, type: :uuid

      t.string :kind, null: false, default: 'residential'
      t.string :status, null: false, default: 'active'

      t.index %i[proponent_id address_id], unique: true

      t.timestamps
    end
  end
end
