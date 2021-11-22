class AddStartsAtToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :starts_at, :datetime
  end
end
