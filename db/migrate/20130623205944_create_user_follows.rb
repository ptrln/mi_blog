class CreateUserFollows < ActiveRecord::Migration
  def change
    create_table :user_follows do |t|
      t.integer :user_id
      t.integer :follower_id

      t.timestamps
    end

    add_index :user_follows, :follower_id
    add_index :user_follows, :user_id
  end
end
