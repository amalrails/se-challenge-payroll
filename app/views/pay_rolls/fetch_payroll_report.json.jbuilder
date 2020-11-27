json.payrollReport do
  json.employeeReports do
    json.array! @payroll_report_object do |object|
      json.extract! object, :employeeId, :payPeriod, :amountPaid
    end
  end
end
