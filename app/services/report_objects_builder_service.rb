# frozen_string_literal: true

class ReportObjectsBuilderService
  def initialize
    @time_report_records = TimeReportRecord.all.order_by_employee_id
    @employee_ids = @time_report_records.uniq_employee_ids
    @object = []
  end

  def object
    set_object
    @object
  end

  def set_object
    @employee_ids.each do |emp_id|
      @employee_time_records = @time_report_records.based_on_employee(emp_id)
                                                   .order_by_report_date
      records_start_date = @employee_time_records.records_start_date
      records_end_date = @employee_time_records.records_end_date
      rate = @employee_time_records.job_group.rate
      start_date = records_start_date
      add_values_to_object(records_end_date, start_date, rate, emp_id)
    end
  end

  def add_values_to_object(records_end_date, start_date, rate, emp_id)
    while start_date < records_end_date
      end_date = start_date + 2.weeks
      time_records_for_pay_period = @employee_time_records.between_dates(start_date, end_date)
      total_working_hours = time_records_for_pay_period.sum(:hours_worked)
      if total_working_hours.positive?
        @object << { employeeId: emp_id, payPeriod: { start_date: start_date.to_date,
                                                      end_date: end_date.to_date },
                     amountPaid: "$#{total_working_hours * rate}" }

      end
      start_date = end_date + 1.day
    end
  end
end
