class CreateStates < ActiveRecord::Migration[7.0]
  def change
    create_table :states do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }

      t.references :country, null: false, foreign_key: true

      t.string :ibge_code, null: false
      t.string :name, null: false
      t.string :uf, null: false, limit: 2

      t.index %i[name country_id], unique: true

      t.timestamps
    end
  end
end
