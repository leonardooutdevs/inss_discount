class CreateStates < ActiveRecord::Migration[7.0]
  def change
    create_table :states, id: :uuid do |t|
      t.references :country, null: false, foreign_key: true, type: :uuid

      t.string :ibge_code, null: false
      t.string :name, null: false
      t.string :uf, null: false, limit: 2

      t.index %i[name country_id], unique: true

      t.timestamps
    end
  end
end
