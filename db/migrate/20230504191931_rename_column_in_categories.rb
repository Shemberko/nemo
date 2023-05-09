class RenameColumnInCategories < ActiveRecord::Migration[7.0]
  def change
    rename_column :post_categories, :category, :name
  end
end
