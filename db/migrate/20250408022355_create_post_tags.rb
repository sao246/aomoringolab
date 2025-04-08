class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :tag, null: false, foreign_key: { to_table: :tags }
      t.references :post, null: false, foreign_key: { to_table: :posts }
      t.timestamps
    end
  end
end
