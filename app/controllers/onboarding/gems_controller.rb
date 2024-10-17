class Onboarding::GemsController < ApplicationController
  before_action :redirect_to_signin, unless: :signed_in?
  before_action :redirect_to_new_mfa, if: :mfa_required_not_yet_enabled?
  
  def edit
  end

  def update
    redirect_to edit_onboarding_users_path
  end
end