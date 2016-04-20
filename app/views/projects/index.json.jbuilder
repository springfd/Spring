json.array!(@projects) do |project|
  json.extract! project, :id, :year, :name, :budget, :exp_personnel, :exp_business, :exp_mix, :exp_other, :exe_desc, :donate_flag, :abbreviation, :account_begin, :account_end
  json.url project_url(project, format: :json)
end
