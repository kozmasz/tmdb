class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.integer :tmdb_id, null: false, index: true
      t.string  :name,    null: false

      t.timestamps
    end
  end
end
