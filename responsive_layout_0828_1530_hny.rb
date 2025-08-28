# 代码生成时间: 2025-08-28 15:30:47
require 'rack/contrib/try_static'
require 'rack/contrib/sass'
require 'tilt'

# Initialize Cuba
Cuba.use Rack::TryStatic, root: 'public', urls: %w[/], try: ['.html', '/index.html']
Cuba.use Rack::Sass, root: 'public', urls: /\.s[ac]ss$/

# Custom error handling
Cuba.use do
  on standard_error do |e, env|
    [500, env['rack.errors'].puts(e.inspect), 'Internal Server Error']
  end
end

# Define routes
Cuba.define do
  # Home page route
  on get do
    res.write 'Welcome to the responsive layout design using Cuba!'
  end

  # Serve static files
  on get, root do
    res.redirect '/public/index.html'
  end

  # Any other route not defined
  on get, '*/' do
    res.write '404 Not Found'
  end
end

# Start the Cuba application
Cuba.run! unless defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby'