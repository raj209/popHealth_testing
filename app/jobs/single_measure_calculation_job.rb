require_relative '../../lib/cql_ext/cqm_execution_calc.rb'

class SingleMeasureCalculationJob < ApplicationJob
  queue_as :measure_calculation

  def perform(patient_ids, measure_id, correlation_id, options)
    measure = Measure.find(measure_id)
    patients = Patient.find(patient_ids)
    qdm_patients = patients.map(&:qdmPatient)
    calc_job = Cqmcalc::CqmExecutionCalc.new(qdm_patients,
                                             [measure],
                                             correlation_id,
                                             options)
    calc_job.execute(true)
  end
end
