class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :country
      t.string :price

      t.timestamps
    end
  end
end
