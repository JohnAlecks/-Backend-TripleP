class AddStreetToPin < ActiveRecord::Migration[5.0]
  def change
    add_column :pins, :street, :string
  end
end
