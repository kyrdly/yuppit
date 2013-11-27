class AddImageRemoteUrlToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :image_remote_url, :string
  end
end
