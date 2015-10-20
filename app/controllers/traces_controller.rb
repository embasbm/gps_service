class TracesController < ApplicationController
  respond_to :json
  before_action :set_points_collection, only: [:create, :update]

  def index
    traces = Trace.all
    render json: traces, status: :ok
  end

  def create
    trace = Trace.new
    if trace.save
      @gps_points_set.each do |gps_point|
        GpsPoint.find_or_create_by!(
            latitude: gps_point[:latitude],
            longitude: gps_point[:longitude],
            trace_id: trace.id
        )
      end
      render json: trace.as_json, status: :created
    else
      render json: trace.as_json(include: errors), status: :unprocessable_entity
    end
  end

  def update
    trace = Trace.find(params[:id])
    trace.gps_points.destroy_all unless trace.gps_points.empty?
    @gps_points_set.each do |gps_point|
      GpsPoint.find_or_create_by!(
          latitude: gps_point[:latitude],
          longitude: gps_point[:longitude],
          trace_id: trace.id
      )
    end
    render json: trace, status: :ok
  end

  def show
    trace = Trace.find(params[:id])
    gps_points = trace.gps_points
    render json: trace.as_json(include: gps_points.as_json), status: :ok
  end

  def destroy
    trace = Trace.find(params[:id])
    trace.gps_points.destroy_all
    if trace.destroy
      render json: trace.as_json , status: :destroyed
    else
      render json: trace.as_json(include: errors), status: :unprocessable_entity
    end
  end

  private

  def set_points_collection
    # assuming that when an empty file is passed to PUT action, we want to delete trace gps points
    @gps_points_set = params[:_json].present? ? params[:_json] : []
  end
end