class OrganizationsController < ApplicationController
  before_action :redirect_to_signin, only: :index, unless: :signed_in?
  before_action :redirect_to_new_mfa, only: :index, if: :mfa_required_not_yet_enabled?
  before_action :redirect_to_settings_strong_mfa_required, only: :index, if: :mfa_required_weak_level_enabled?

  before_action :find_organization, only: %i[show]

  layout "subject"

  # GET /organizations
  def index
    @memberships = current_user.memberships.includes(:organization)
  end

  # GET /organizations/1
  def show
    add_breadcrumb t("breadcrumbs.org_name", name: @organization.handle)

    @latest_events = [] # @organization.latest_events
    @gems = [] # @organization.rubygems
    @gems_count = @gems.size
    @memberships = @organization.memberships
    @memberships_count = @organization.memberships.count
  end

  private

  def find_organization
    @organization = Organization.find_by_handle!(params[:id])
  end
end
