class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :genre
      t.string :address
      t.string :likey
      t.text :description
      t.string :url

      t.timestamps
    end
  end
end
