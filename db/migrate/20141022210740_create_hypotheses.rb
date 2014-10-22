class CreateHypotheses < ActiveRecord::Migration
  def change
    create_table :hypotheses do |t|
      t.string :short_name
      t.integer :state
      t.integer :business_model_part
      t.text :hypotheses
      t.text :experiment
      t.text :pass_fail_criterion
      t.integer :created_by

      t.timestamps
    end
  end
end
