class CreateAccessPermissionLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :access_permission_levels do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }

      t.references :access_permission, null: false, foreign_key: true
      t.references :access_level, null: false, foreign_key: true

      t.index %i[access_permission_id access_level_id], unique: true, name: 'index_apl_on_ap_id_and_al_id'

      t.timestamps
    end
  end
end
