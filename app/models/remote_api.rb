class RemoteApi

  RUNTASTIC_API_URL = 'https://codingcontest.runtastic.com/api/elevations/'
  EVENT_MACHINE_OPTIONS = {
      connect_timeout: 120,
      inactivity_timeout: 120
  }
  RUNTASTIC_HEAD = {
      'Content-Type' => 'application/json'
  }


  def single_request(point)
    elevation = query_remote(URI.parse(RUNTASTIC_API_URL + '/' + point.latitude + '/' + point.longitude))
  end

  def bulk_request(points_collection)
    elevations_collection = query_remote(URI.parse(RUNTASTIC_API_URL + 'bulk'), points_collection)
  end

  private

  def query_remote(url, request_params = '')
    http = nil
    EventMachine.run {
      if request_params.present?
        http = EventMachine::HttpRequest.new(url, EVENT_MACHINE_OPTIONS).post(head:  RUNTASTIC_HEAD, body: request_params.to_json)
      else
        http = EventMachine::HttpRequest.new(url, EVENT_MACHINE_OPTIONS).get(head: RUNTASTIC_HEAD)
      end

      http.errback {
        Rails.logger.warn "Runtastic API lookup failure:\n#{url.to_s}"
        EventMachine.stop
      }
      http.callback {
        EventMachine.stop
      }
    }

    if http.response_header.status == 200
      http.response
    else
      Rails.logger.warn "Runtastic API lookup failure:\n#{url.to_s}"
      nil
    end
  end

end
