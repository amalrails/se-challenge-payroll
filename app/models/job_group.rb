# frozen_string_literal: true

class JobGroup < ApplicationRecord
  has_many :employees
end
