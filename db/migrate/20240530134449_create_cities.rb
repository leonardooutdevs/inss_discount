class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }

      t.references :state, null: false, foreign_key: true

      t.string :ibge_code, null: false
      t.string :name, null: false

      t.index %i[name state_id], unique: true

      t.timestamps
    end
  end
end
