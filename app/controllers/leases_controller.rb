class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  def index
    leases = Lease.all
    render json: leases, status: :ok
  end

  def show
    lease = find_lease
    render json: lease, status: :ok
  end

  def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
  end

  def destroy
    lease = find_lease
    lease.destroy
    render json: { messages: "#{lease} destroyed" }
  end

  private

  def find_lease
    Lease.find(params[:id])
  end

  def render_not_found; end

  def render_invalid; end
  def lease_params
    params.permit(:rent, :tenant_id, :apartment_id)
  end
end
