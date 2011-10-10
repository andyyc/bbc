Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '157311767691429', 'bcb8f02ffedf4764cddf9ea8b2f338e7'
end
