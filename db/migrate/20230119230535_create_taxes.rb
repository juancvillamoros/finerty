class CreateTaxes < ActiveRecord::Migration[7.0]
  def change
    create_table :taxes do |t|
      t.decimal :arl
      t.decimal :salud
      t.decimal :pension
      t.decimal :fsp
      t.decimal :cesantias
      t.decimal :ccf
      t.decimal :total
      t.references :user, null: false, foreign_key: true
      t.references :salary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
