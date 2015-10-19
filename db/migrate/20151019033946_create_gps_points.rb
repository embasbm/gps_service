class CreateGpsPoints < ActiveRecord::Migration
  def change
    create_table :gps_points do |t|
      t.string :latitude
      t.string :longitude

      t.timestamps null: false
    end
  end
end
