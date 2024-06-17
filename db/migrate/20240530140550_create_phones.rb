class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }

      t.string :number, null: false, limit: 32

      t.index :number, unique: true

      t.timestamps
    end
  end
end
