class AddAreaToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :area, :string
  end
end
