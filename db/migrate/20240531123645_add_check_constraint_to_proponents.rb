class AddCheckConstraintToProponents < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      ALTER TABLE proponents
      ADD CONSTRAINT check_numeric_document
      CHECK (document ~ '^\\d+$');
    SQL
  end
end
