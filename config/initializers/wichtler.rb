Wichtler::Application.configure do
  config.wichtler = OpenStruct.new(
    from_email: ENV['FROM_EMAIL']
  )
end
