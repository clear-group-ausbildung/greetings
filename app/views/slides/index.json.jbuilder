json.array!(@slides) do |slide|
  json.extract! slide, :id, :showcasable
  json.url slide_url(slide, format: :json)
end
