class AddOpengraphImageToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :opengraph_image, :string
  end
end
