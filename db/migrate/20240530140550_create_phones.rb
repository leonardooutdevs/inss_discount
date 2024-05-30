class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones, id: :uuid do |t|
      t.string :number, null: false, limit: 32

      t.index :number, unique: true

      t.timestamps
    end
  end
end
