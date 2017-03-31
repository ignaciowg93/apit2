module Response
  def json_response(object)
    render json: object, status: 200
  end
end