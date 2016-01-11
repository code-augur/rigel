class CreateSeries < ActiveRecord::Migration[5.0]
  def change
    create_table :series do |t|
      t.jsonb :data

      t.timestamps
    end

    add_index :series, :data, using: :gin
  end
end
