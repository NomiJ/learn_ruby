class AddCategroyIdToPlays < ActiveRecord::Migration[5.0]
  def change
    add_column :plays, :category_id, :integer
  end
end
