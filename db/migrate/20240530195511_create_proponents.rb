class CreateProponents < ActiveRecord::Migration[7.0]
  def change
    create_table :proponents, id: :uuid do |t|
      t.references :address, null: false, foreign_key: true, type: :uuid
      t.references :phone, null: false, foreign_key: true, type: :uuid

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
