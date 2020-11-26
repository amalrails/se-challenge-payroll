# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect('pay_rolls/home')
  resource :pay_rolls, only: [] do
    collection do
      get 'home'
      post 'import'
      post 'generate_payroll_report'
    end
  end
end

