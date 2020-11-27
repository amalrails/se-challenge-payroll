require 'rails_helper'

RSpec.describe ReportObjectsBuilderService, type: :model do
  describe '#object' do
    let!(:jg1) { create(:job_group, group_name: 'A', rate: 20) }
    let!(:jg2) { create(:job_group, group_name: 'B', rate: 30) }
    let!(:emp) { create(:employee, job_group_id: jg1.id) }
    let!(:time_report) { create(:time_report, name: 'time-report-40.csv') }
    let!(:time_report_record) { create(:time_report_record, hours_worked: 10, employee_id: emp.id, time_report_id: time_report.id, job_group_id: emp.job_group.id, report_date: Date.yesterday) }

    let(:expected_object) { [{ amountPaid: '$200.0', employeeId: 1, payPeriod: {endDate: Date.parse("Mon, 30 Nov 2020"), startDate: Date.parse("Mon, 16 Nov 2020")}}] }

    it 'returns a array of hashes' do
      response_object = ReportObjectsBuilderService.new.object
      expect(response_object).to eq(expected_object)
    end
  end
end
