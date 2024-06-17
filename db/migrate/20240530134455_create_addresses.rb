class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }

      t.references :city, null: false, foreign_key: true

      t.string :address, null: false, default: '', limit: 128
      t.string :number, limit: 32
      t.string :complement, limit: 32
      t.string :neighborhood, null: false, default: '', limit: 128
      t.string :zip_code, null: false, default: '', limit: 32

      t.index %i[city_id address number complement neighborhood zip_code], unique: true, name: 'index_addresses_on_city_and_details'

      t.timestamps
    end
  end
end
