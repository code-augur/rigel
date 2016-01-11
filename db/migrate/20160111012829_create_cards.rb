class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.jsonb :data, null: false, default: '{}'

      t.timestamps
    end

    add_index :cards, :data, using: :gin
  end
end
