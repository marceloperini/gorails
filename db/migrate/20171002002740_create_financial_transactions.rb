class CreateFinancialTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :financial_transactions do |t|
      t.string :object
      t.string :origin
      t.string :transaction_type, limit: 1
      t.decimal :value, precision: 13, scale: 2
      t.references :user, index: true, foreign_key: true
      t.datetime :payment_date
      t.string :payment_method
      t.boolean :consolidated, null: false, default: false
      t.datetime :consolidation_date

      t.timestamps null: false
    end
  end
end