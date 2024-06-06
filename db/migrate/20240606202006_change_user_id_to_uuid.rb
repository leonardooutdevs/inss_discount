class ChangeUserIdToUuid < ActiveRecord::Migration[7.0]
  def change
    up_only do
      add_column :users, :new_id, :uuid, default: 'gen_random_uuid()'
      remove_column :users, :id
      rename_column :users, :new_id, :id
      execute "ALTER TABLE users ADD PRIMARY KEY (id);"
    end
  end
end
