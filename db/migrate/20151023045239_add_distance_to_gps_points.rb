class AddDistanceToGpsPoints < ActiveRecord::Migration
  def change
    add_column :gps_points, :distance, :integer
  end
end
