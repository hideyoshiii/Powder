class AddArticleRefToClips < ActiveRecord::Migration[5.1]
  def change
    add_reference :clips, :article, foreign_key: true
  end
end
