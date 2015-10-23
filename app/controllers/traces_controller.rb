class TracesController < ApplicationController
  respond_to :json
  before_action :set_points_collection, only: [:create, :update]

  def index
    traces = Trace.all.collect {|trace| trace.get_collection}
    render json: traces.as_json, status: :ok
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
      trace.update_distances
      set_points_elevations(trace)
      render json: trace.as_json, status: :created
    else
      render json: trace.as_json(include: errors), status: :unprocessable_entity
    end
  end

  def update
    trace = Trace.find(params[:id])

    # assuming that when an empty file is passed to PUT action, we want to delete trace gps points
    if !trace.gps_points.empty? || @gps_points_set.empty?
      trace.gps_points.destroy_all
    end

    @gps_points_set.each do |gps_point|
      GpsPoint.find_or_create_by!(
          latitude: gps_point[:latitude],
          longitude: gps_point[:longitude],
          trace_id: trace.id
      )
    end
    trace.update_distances
    set_points_elevations(trace)
    render json: trace, status: :ok
  end

  def show
    trace = Trace.find(params[:id])
    pgs_points_collection = trace.get_collection
    render json: pgs_points_collection.as_json, status: :ok
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
    @gps_points_set = params[:_json].present? ? params[:_json] : []
  end

  def set_points_elevations(trace)
    remote_api = RemoteApi.new
    elevations   = JSON.parse(remote_api.bulk_request(@gps_points_set))
    trace.update_elevations(elevations)
  end
end