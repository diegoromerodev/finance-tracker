class DropTableTableFriendships < ActiveRecord::Migration[6.0]
  def change
  	drop_table :table_friendships
  end
end
