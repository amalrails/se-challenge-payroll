# frozen_string_literal: true

class PayRollsController < ApplicationController
  def home

  end

  def import
    CSV.foreach(file.path, headers: true) do |row|
      time_report_record_hash = row.to_hash
      byebug
      time_report_record = find_or_create_by!(player: time_report_record_hash['player'], team: time_report_record_hash['team'])
      rushing.update_attributes(player: rushing_hash['player'], team: rushing_hash['team'],
                                pos: rushing_hash['pos'], att: rushing_hash['att'],
                                att_by_g: rushing_hash['att_by_g'], yds: rushing_hash['yds'],
                                avg: rushing_hash['avg'], yds_by_g: rushing_hash['yds_by_g'],
                                td: rushing_hash['td'], lng: rushing_hash['Lng'],
                                first: rushing_hash['1st'], first_percentage: rushing_hash['first_percentage%'],
                                twenty_plus: rushing_hash['twenty_plus'], forty_plus: rushing_hash['forty_plus'],
                                fum: rushing_hash['fum'])
    end
    redirect_to root_url, notice: 'Employees Working Hours data has been imported.'
  end

  def generate_payroll_report
  end
end
