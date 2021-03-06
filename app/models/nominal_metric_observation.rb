class NominalMetricObservation < ActiveRecord::Base
  belongs_to :metric_definition
  validates :metric_definition_id, presence: true
  belongs_to :virtual_machine_instance
end
