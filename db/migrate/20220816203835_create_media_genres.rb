class CreateMediaGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :media_genres do |t|
      t.integer :tmdb_medium_id, foreign_key: true, null: false
      t.integer :tmdb_genre_id,  foreign_key: true, null: false

      t.timestamps
    end

    add_index :media_genres, [:tmdb_medium_id, :tmdb_genre_id], unique: true, name: "custom_uniq_index_1"
  end
end
