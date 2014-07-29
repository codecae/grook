module Grook

  module Web

    class SimpleServlet < WEBrick::HTTPServlet::AbstractServlet

      def _get(request)
	return 500, 'text/plain', 'Not Implemented'
      end

      def _post(request)
	return 500, 'text/plain', 'Not Implemented'
      end

      def do_GET(request,response)
	status, content_type, body = _get(request)

	response.status = status
	response['Content-Type'] = content_type
	response.body = body
      end

      def do_POST(request,response)
	status, content_type, body = _post(request)

	response.status = status
	response['Content-Type'] = content_type
	response.body = body
      end

    end

  end

end
