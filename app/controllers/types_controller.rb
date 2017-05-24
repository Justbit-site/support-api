class TypesController < ApplicationController
  before_action :set_want
  before_action :set_want_type, only: [:show, :update, :destroy]

  # GET /wants/:want_id/types
  def index
    json_response(@want.types)
  end

  # GET /wants/:want_id/types/:id
  def show
    json_response(@type)
  end

  # POST /wants/:want_id/types
  def create
    @want.types.create!(type_params)
    json_response(@want, :created)
  end

  # PUT /wants/:want_id/types/:id
  def update
    @type.update(type_params)
    head :no_content
  end

  # DELETE /wants/:want_id/types/:id
  def destroy
    @type.destroy
    head :no_content
  end

  private

  def type_params
    params.permit(:name, :done)
  end

  def set_want
    @want = Want.find(params[:want_id])
  end

  def set_want_type
    @type = @want.types.find_by!(id: params[:id]) if @want
  end
end
