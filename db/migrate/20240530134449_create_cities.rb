class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities, id: :uuid do |t|
      t.references :state, null: false, foreign_key: true, type: :uuid

      t.string :ibge_code, null: false
      t.string :name, null: false

      t.index %i[name state_id], unique: true

      t.timestamps
    end
  end
end
