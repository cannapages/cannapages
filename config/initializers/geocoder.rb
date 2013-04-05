# config/initializers/geocoder.rb
Geocoder.configure(

  # geocoding service (see below for supported options):
  lookup: :yahoo,

  # to use an API key:
  api_key: ["dj0yJmk9ZnhpR3hkNENVaG5LJmQ9WVdrOWRXODVWazFXTnpnbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD0yYQ--", "b500e14b7a4c11be9f423a8f6461422b76fbde3b"],

  # geocoding service request timeout, in seconds (default 3):
  timeout: 5

)
