json.payrollReport do
  json.employeeReports @employee_ids do |employee_id|
    employee_time_report_records = @time_report_records.where(employee_id: employee_id)
                                                       .order(:report_date)


    records_start_date = employee_time_report_records.first.report_date.beginning_of_month
    records_end_date = employee_time_report_records.last.report_date.end_of_month
    job_group = employee_time_report_records.first.job_group
    start_date = records_start_date


    while start_date < records_end_date do
      end_date = start_date + 2.weeks
      time_records_for_pay_period = employee_time_report_records.where(report_date: start_date..end_date)
      total_working_hours = time_records_for_pay_period.sum(:hours_worked)

      if total_working_hours > 0
        json.child! do
          json.set! :employeeId, employee_id
          json.set! :payPeriod do
            json.set! :start_date, start_date.to_date
            json.set! :end_date, end_date.to_date
          end
          json.set! :amountPaid, "$#{total_working_hours * job_group.rate}"
        end
      end
      records_start_date = end_date + 1.day
    end
  end
end
