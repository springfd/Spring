json.array!(@stories) do |story|
  json.extract! story, :id, :description, :topic, :video_url
  json.url story_url(story, format: :json)
end
