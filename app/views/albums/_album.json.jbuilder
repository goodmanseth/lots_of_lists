json.extract! album, :id, :title, :artist, :description, :created_at, :updated_at
json.url album_url(album, format: :json)
