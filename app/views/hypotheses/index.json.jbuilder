json.array!(@hypotheses) do |hypothesis|
  json.extract! hypothesis, :id, :short_name, :state, :business_model_part, :hypotheses, :experiment, :pass_fail_criterion, :created_by
  json.url hypothesis_url(hypothesis, format: :json)
end
