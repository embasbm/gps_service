class GpsPointsController < ApplicationController
  # respond_to :json

  def index
    if params[:trace_id].present?
      gps_points = GpsPoint.where(trace_id: params[:trace_id])
    else
      gps_points = GpsPoint.all
    end
    render json: gps_points, status: :ok
  end

  def create
    gps_point = GpsPoint.find_or_create_by!(gps_point_params)
    if gps_point.save
      render json: gps_point.as_json , status: :created
    else
      render json: gps_point.as_json(include: errors), status: :unprocessable_entity
    end
  end

  def destroy
    gps_point = GpsPoint.find(params[:id])
    if gps_point.destroy
      render json: gps_point.as_json , status: :destroyed
    else
      render json: gps_point.as_json(include: errors), status: :unprocessable_entity
    end
  end

  private

  def gps_point_params
    params.require(:gps_point).permit(:latitude, :longitude, :trace_id)
  end
end