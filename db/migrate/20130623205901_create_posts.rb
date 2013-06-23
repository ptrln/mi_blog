class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :user_id
      t.string :title

      t.timestamps
    end

    add_index :posts, :user_id
  end
end
