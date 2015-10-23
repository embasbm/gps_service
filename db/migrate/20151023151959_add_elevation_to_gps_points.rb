class AddElevationToGpsPoints < ActiveRecord::Migration
  def change
    add_column :gps_points, :elevation, :integer
  end
end
