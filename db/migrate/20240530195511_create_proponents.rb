class CreateProponents < ActiveRecord::Migration[7.0]
  def change
    create_table :proponents do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }

      t.references :salary, null: false, foreign_key: true

      t.decimal :gross_salary, null: false
      t.decimal :discount, null: false
      t.decimal :net_salary, null: false

      t.string :name, null: false, limit: 128
      t.string :document, null: false, limit: 64
      t.date :birth_date, null: false

      t.index :document, unique: true

      t.timestamps
    end
  end
end
