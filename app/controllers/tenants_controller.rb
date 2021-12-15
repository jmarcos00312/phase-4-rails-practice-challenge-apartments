class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid



def index
    tenants = Tenant.all
    render json: tenants, status: :ok
end

def show
    tenant = find_tenants
    render json: tenant, status: :ok
end

def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
end

def update
    tenant = find_tenants
    tenant.update!(tenant_params)
    render json: tenant, status: :ok
end

def destroy
    tenant = find_tenants
    tenant.destroy
    render json: { messages: "#{tenant.name} destroyed" }
end


private

def find_tenants
    Tenant.find(params[:id])
end

def tenant_params
    params.permit(:name, :age)
end

def render_not_found
    render json: {error: "Tenant Not Found"}, status: :not_found
end

def render_invalid(invalid)
    render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity
end

def render_routing_error
render json:{error: "Tenant Routing Error"}, status: :unprocessable_entity
end

end