json.array!(@sign_reports) do |sign_report|
  json.extract! sign_report, :id, :title, :year
  json.url sign_report_url(sign_report, format: :json)
end
