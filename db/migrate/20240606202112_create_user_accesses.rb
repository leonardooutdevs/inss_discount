class CreateUserAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :user_accesses, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :access_permission_level, null: false, foreign_key: true, type: :uuid

      t.index %i[user_id access_permission_level_id], unique: true

      t.timestamps
    end
  end
end
