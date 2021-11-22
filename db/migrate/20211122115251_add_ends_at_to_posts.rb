class AddEndsAtToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :ends_at, :datetime
  end
end
