class AddMicropostIdToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :MicropostId, :integer
  end
end
