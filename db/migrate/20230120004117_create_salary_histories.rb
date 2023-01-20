class CreateSalaryHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :salary_histories do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :amount
      t.references :user, null: false, foreign_key: true
      t.references :salary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
