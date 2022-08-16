class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.integer :tmdb_id,           null: false, index: true
      t.string  :media_type,        null: false
      t.boolean :adult,             null: false, default: false
      t.date    :release_date
      t.string  :title
      t.string  :original_title
      t.string  :original_language
      t.text    :overview
      t.float   :vote_average
      t.integer :vote_count
      t.string  :poster_path
      t.float   :popularity
      t.string  :backdrop_path

      t.timestamps
    end

    add_index :media, [:tmdb_id, :media_type], unique: true, name: "custom_uniq_index_2"

  end
end
