# frozen_string_literal: true

class PayRollsController < ApplicationController
  def import
    message = begin
      TimeReport.import!(params[:file])
      'Employee Working Hours data has been imported!!'
    rescue ActiveRecord::RecordInvalid => e
      e.message
    end
    redirect_to root_url, notice: message
  end

  def generate_payroll_report
    @time_report_records = TimeReportRecord.all.order(:employee_id)
    @employee_ids = @time_report_records.pluck(:employee_id).uniq
    # render :file => 'generate_payroll_report.json.erb', :content_type => 'application/json'
  end
end
