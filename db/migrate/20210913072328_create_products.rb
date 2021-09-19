class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string     :title,                null: false
      t.text       :product_description,  null: false
      t.integer    :category_id,          null: false
      t.integer    :product_condition_id, null: false
      t.integer    :shipping_charge_id,   null: false
      t.integer    :shipping_area_id,     null: false
      t.integer    :shipping_ship_id,     null: false
      t.integer    :price,                null: false
      t.references :user,                 null: false, foreign_key: true
      t.timestamps
    end
  end
end
