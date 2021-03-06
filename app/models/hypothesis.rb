class Hypothesis < ActiveRecord::Base

  belongs_to :author, class_name: "User", foreign_key: :created_by
  has_paper_trail

  STATE = {
    :draft => 3,
    :accepted => 2,
    :hypothetical => 1,
    :declined => 0
  }

  MODEL_PARTS = {
    :key_partners => 0,
    :key_activities => 1,
    :key_resources => 2,
    :value_propositions => 3,
    :customer_relationship => 4,
    :channels => 5,
    :target_market => 6,
    :cost_structure => 7,
		:revenue_structure => 8
	}

  #Define Methos like .user? admin? tutor? method
	MODEL_PARTS.each do |meth, code|
		define_method("#{meth}?") { self.role == code }
	end

	#Define user! admin! tutor! method
	MODEL_PARTS.each do |meth, code|
		define_method("#{meth}!") { self.role = code }
	end

  def filtered_state
    if experiment.to_s == '' or
        pass_fail_criterion.to_s == '' or
        hypotheses.to_s == ''
      return STATE[:draft]
    else
      return state
    end
  end

  def bootstraped_state
    case filtered_state
    when STATE[:accepted]
      return "success"
    when STATE[:hypothetical]
      return "warning"
    when STATE[:declined]
      return "danger"
    when STATE[:draft]
        return "default"
    else
      return "default"
    end
  end

  #f.input :role, as: :select, collection: User::ROLES, :hint => "Unless preregistered is chosen, the user need to have a password.", :include_blank => false
end
