class AddSetCodeIndexToSeries < ActiveRecord::Migration[5.0]
  def change
     execute <<-SQL
       CREATE INDEX series_data_code_index ON series ((data->>'code'))
     SQL
  end
end
