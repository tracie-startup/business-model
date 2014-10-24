module HypothesesHelper
  def business_plan_part part
    value = Hypothesis::MODEL_PARTS[part]
    cards = ""
    @grouped_hypotheses[value].each do |hypothesis|

      target = hypothesis_path hypothesis
      target = edit_hypothesis_path hypothesis if hypothesis.filtered_state == Hypothesis::STATE[:draft]

      cards += link_to hypothesis.short_name, target, :class=>"btn btn-xs btn-#{hypothesis.bootstraped_state}"

    end if @grouped_hypotheses[value]

    "<div class=\"business-model-box #{part}\">
      <a href='#{new_hypothesis_path :model_part => part}' class='btn btn-default btn-xs add-hypothesis-button'><span class='glyphicon glyphicon-plus'></span></a>
      <h3>#{part.to_s.humanize}</h3>
      #{cards}
    </div>".html_safe
  end
end
