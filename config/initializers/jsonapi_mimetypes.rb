#  config/initializers/jsonapi_mimetypes.rb
# Without this mimetype registration, controllers will not automatically parse JSON API params.
module JSONAPI
    MIMETYPE = "application/vnd.api+json"
  end
  Mime::Type.register(JSONAPI::MIMETYPE, :api_json)
  
  # Rails 4
  ActionDispatch::ParamsParser::DEFAULT_PARSERS[Mime::Type.lookup(JSONAPI::MIMETYPE)] = lambda do |body|
    JSON.parse(body)
  end
  
  # Rails 5 moved DEFAULT_PARSERS
  ActionDispatch::Http::Parameters::DEFAULT_PARSERS[:api_json] = lambda do |body|
    JSON.parse(body)
  end
  ActionDispatch::Request.parameter_parsers = ActionDispatch::Request::DEFAULT_PARSERS