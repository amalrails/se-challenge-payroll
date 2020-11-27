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

  def fetch_payroll_report
    @payroll_report_object = ReportObjectsBuilderService.new.object
  end
end
