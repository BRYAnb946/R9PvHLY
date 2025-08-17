# 代码生成时间: 2025-08-17 16:47:22
#!/usr/bin/env ruby
# encoding: utf-8

# ThemeSwitcher Service
# This service manages theme switching functionality within the CUBA framework

require 'cuba'
require 'cuba/render'
require 'slim'

class ThemeSwitcher < Cuba
  # Set the application's theme
  def set_theme(theme_name)
    session[:theme] = theme_name
  end

  # Get the current theme
  def current_theme
    session[:theme] || 'default'
  end

  # Define the routes
  define do
    # Route to switch theme
    on get, 'switch_theme', param('theme') do |theme_name|
      if theme_name && ['light', 'dark'].include?(theme_name)
        set_theme(theme_name)
        redirect to('/')
      else
        # Handle the error if the theme name is not valid
        status 400
        'Invalid theme specified.'
      end
    end

    # The root route
    on get do
      # Render the template with the current theme
      slim :index, layout: false, locals: { theme: current_theme }
    end
  end
end

# Slim template for the index page
__END__
@@ index
doctype html
html
  head
    title Theme Switcher
    link rel='stylesheet' href="/themes/#{theme}.css"
  body
    h1 Welcome to the Theme Switcher!
    form action='/switch_theme' method='get'
      label for='theme' Select Theme:
      select name='theme'
        option value='light' Light
        option value='dark' Dark
      input type='submit' value='Switch Theme'
