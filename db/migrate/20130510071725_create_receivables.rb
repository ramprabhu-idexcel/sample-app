class CreateReceivables < ActiveRecord::Migration
  def change
    create_table :receivables do |t|
      t.string :account_no
      t.text :name
      t.integer :invoice
      t.integer :original_date
      t.string :amount
      t.integer :due_date      
      t.timestamps
    end
  end
end
