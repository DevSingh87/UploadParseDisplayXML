json.array!(@geos) do |geo|
  json.extract! geo, :id, :title
  json.url geo_url(geo, format: :json)
end
