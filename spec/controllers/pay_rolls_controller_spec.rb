# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayRollsController, type: :controller do
  describe 'post #import' do
    let(:response_body) { JSON.parse(response.body) }

    context 'Valid params' do
      let(:valid_file) { Rack::Test::UploadedFile.new 'spec/support/fixtures/time-report-40.csv' }
      let(:valid_file2) { Rack::Test::UploadedFile.new 'spec/support/fixtures/time-report-4.csv' }
      before :each do
        create(:job_group, group_name: 'A', rate: 20)
        create(:job_group, group_name: 'B', rate: 30)
      end

      it 'returns http redirect' do
        post :import, params: { file: valid_file }
        expect(response).to have_http_status(302)
      end

      it 'returns success flash message' do
        post :import, params: { file: valid_file }
        expect(flash[:notice]).to eq('Employee Working Hours data has been imported!!')
      end

      it 'invokes import method in TimeReport' do
        expect(TimeReport).to receive(:import!).with('foo.csv')
        post :import, params: { file: 'foo.csv' }
      end

      context 'Valid file' do
        it 'increments the TimeReportRecord count by 1' do
          expect { post :import, params: { file: valid_file2 } }.to change { TimeReportRecord.count }.by(1)
          expect(flash[:notice]).to eq('Employee Working Hours data has been imported!!')
        end
      end
    end

    context 'Invalid params' do
      let(:file) { Rack::Test::UploadedFile.new 'spec/support/fixtures/time-report-40.csv' }
      let(:file2) { Rack::Test::UploadedFile.new 'spec/support/fixtures/time-report-4.csv' }
      before :each do
        create(:job_group, group_name: 'A', rate: 20)
        create(:job_group, group_name: 'B', rate: 30)
      end

      it 'returns http redirect' do
        post :import, params: { file: file }
        expect(response).to have_http_status(302)
      end

      it 'returns error message' do
        post :import, params: { file: file }
        post :import, params: { file: file }
        expect(flash[:notice]).to eq('Validation failed: Name has already been taken')
      end

      it 'invokes import method in TimeReport' do
        expect(TimeReport).to receive(:import!).with('foo.csv')
        post :import, params: { file: 'foo.csv' }
      end

      context 'Invalid file' do
        it 'does not increment the TimeReportRecord count' do
          post :import, params: { file: file }
          expect { post :import, params: { file: file } }.to change { TimeReportRecord.count }.by(0)
          expect(flash[:notice]).to eq('Validation failed: Name has already been taken')
        end
      end
    end
  end

  describe 'get #generate_payroll_report' do
    render_views
    let(:json) { JSON.parse(response.body) }

    it 'returns http success' do
      get :fetch_payroll_report, format: :json
      expect(response).to have_http_status(:success)
    end

    it 'invokes object method in ReportObjectsBuilderService' do
      expect_any_instance_of(ReportObjectsBuilderService).to receive(:object)
      get :fetch_payroll_report, format: :json
    end

    context 'Data is available' do
      before :each do
        create(:job_group, group_name: 'A', rate: 20)
        create(:job_group, group_name: 'B', rate: 30)
      end

      let(:valid_file) { Rack::Test::UploadedFile.new 'spec/support/fixtures/time-report-40.csv' }
      let(:expected_json) {{"payrollReport"=>{"employeeReports"=>[{"employeeId"=>1,
                            "payPeriod"=>{"startDate"=>"2016-11-01", "endDate"=>"2016-11-15"},
                            "amountPaid"=>"$150.0"}, {"employeeId"=>2, "payPeriod"=>{"startDate"=>"2016-11-01", "endDate"=>"2016-11-15"}, "amountPaid"=>"$240.0"}, {"employeeId"=>3, "payPeriod"=>{"startDate"=>"2016-11-01", "endDate"=>"2016-11-15"}, "amountPaid"=>"$350.0"}]}}}

      it 'returns json data' do
        post :import, params: { file: valid_file }
        get :fetch_payroll_report, format: :json
        expect(json.empty?).to eq(false)
      end

      it 'returns json data in the expected format' do
        post :import, params: { file: valid_file }
        get :fetch_payroll_report, format: :json
        expect(json).to eq(expected_json)
      end
    end
  end
end
