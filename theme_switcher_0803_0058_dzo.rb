# 代码生成时间: 2025-08-03 00:58:46
# theme_switcher.rb
# This script provides a theme switching functionality within a CUBA-based application.

# Custom exception for theme switching errors.
class ThemeSwitchError < StandardError; end

# ThemeManager class handles theme switching logic.
class ThemeManager
  # List of available themes.
  AVAILABLE_THEMES = %w[light dark].freeze

  attr_reader :current_theme

  # Initialize a new ThemeManager instance with the default theme.
  def initialize(default_theme = 'light')
    raise ThemeSwitchError, 'Invalid default theme' unless AVAILABLE_THEMES.include?(default_theme)
    @current_theme = default_theme
  end

  # Switch to a new theme provided it is available.
  def switch_theme(new_theme)
    raise ThemeSwitchError, 'Invalid theme' unless AVAILABLE_THEMES.include?(new_theme)
    @current_theme = new_theme
    puts "Theme switched to #{@current_theme}"
  end

  # Check if the current theme is one of the available themes.
  def valid_theme?(theme)
    AVAILABLE_THEMES.include?(theme)
  end
end

# Example usage of ThemeManager.
if __FILE__ == $0
  theme_manager = ThemeManager.new
  puts "Current theme: #{theme_manager.current_theme}"

  begin
    # Attempt to switch themes.
    theme_manager.switch_theme('dark')
  rescue ThemeSwitchError => e
    puts e.message
  end
end