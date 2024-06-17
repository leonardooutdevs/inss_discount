class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }
      t.string :name, null: false
      t.timestamps
    end
  end
end
