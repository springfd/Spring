json.array!(@links) do |link|
  json.extract! link, :id, :name, :web_addr
  json.url link_url(link, format: :json)
end
