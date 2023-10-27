class ChangePriceToFloatInFoods < ActiveRecord::Migration[7.0]
  def change
    change_column :foods, :price, :float
  end
end
