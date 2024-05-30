class CreateSalaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries, id: :uuid do |t|
      t.string :salary_range, null: false
      t.decimal :max_amount, null: false, default: 0
      t.decimal :min_amount, null: false, default: 0
      t.decimal :calculation_basis, null: false, default: 0

      t.string :status, null: false, default: 'active'

      t.index %i[salary_range calculation_basis], unique: true

      t.timestamps
    end
  end
end
