class AddIndexToCardData < ActiveRecord::Migration[5.0]
  def change
     execute <<-SQL
       CREATE INDEX card_data_id_index ON cards ((data->>'id'))
     SQL
  end
end
