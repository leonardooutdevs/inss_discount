class CreateUserAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_accesses do |t|
      t.string :uuid, null: false, default: -> { "gen_random_uuid()" }, index: { unique: true }

      t.references :user, null: false, foreign_key: true
      t.references :access_permission_level, null: false, foreign_key: true

      t.index %i[user_id access_permission_level_id], unique: true

      t.timestamps
    end
  end
end
