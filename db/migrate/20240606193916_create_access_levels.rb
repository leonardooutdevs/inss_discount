class CreateAccessLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :access_levels, id: :uuid  do |t|
      t.string :name, null: false, limit: 64
      t.string :kind, null: false, limit: 64

      t.index :kind, unique: true

      t.timestamps
    end
  end
end