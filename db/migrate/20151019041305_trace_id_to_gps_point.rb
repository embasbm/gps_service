class TraceIdToGpsPoint < ActiveRecord::Migration
  def change
    add_column :gps_points, :trace_id, :integer
  end
end
