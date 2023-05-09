class AddAsotiationBetweenPostAndCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :post_category, foreign_key: true
  end
end
