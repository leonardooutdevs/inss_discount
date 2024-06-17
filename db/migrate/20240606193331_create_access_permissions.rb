class CreateAccessPermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :access_permissions  do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }

      t.string :name, null: false, limit: 64
      t.string :model, null: false, limit: 64

      t.string :status, null: false, default: 'active'

      t.index :model, unique: true

      t.timestamps
    end
  end
end
