# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Local development origin
    origins "http://localhost:3001"

    # Production origins
    origins "https://thisdev.rocks", "https://www.thisdev.rocks"

    resource "*",
      headers: :any,
      methods: %i[get post put patch delete options head],
      expose: [ "Authorization" ]
  end
end
