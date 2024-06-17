class CreateProponentPhones < ActiveRecord::Migration[7.0]
  def change
    create_table :proponent_phones do |t|
      t.references :proponent, null: false, foreign_key: true
      t.references :phone, null: false, foreign_key: true

      t.string :kind, null: false, default: 'residential'
      t.string :status, null: false, default: 'active'

      t.index %i[proponent_id phone_id], unique: true

      t.timestamps
    end
  end
end
