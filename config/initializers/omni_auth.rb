Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "523258854979.apps.googleusercontent.com", "uAGI_T9g6Ujxus1mwSzf81Fy", {access_type: 'online', approval_prompt: '', redirect_uri: "http://localhost:3000/google_oauth2/callback"}
end

OmniAuth.config.on_failure do |env|
  [302, {'Location' => '/', 'Content-Type'=> 'text/html'}, []]
end