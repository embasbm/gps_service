class CreateTraces < ActiveRecord::Migration
  def change
    create_table :traces do |t|

      t.timestamps null: false
    end
  end
end
