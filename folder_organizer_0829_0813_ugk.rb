# 代码生成时间: 2025-08-29 08:13:39
# folder_organizer.rb
# This script organizes folders by sorting files into appropriate subfolders.

require 'find'
require 'fileutils'

# FolderOrganizer class responsible for sorting files into subfolders
class FolderOrganizer
  # Initialize with the root directory to organize
  def initialize(root_dir)
    @root_dir = root_dir
  end

  # Method to organize the folder
  def organize
    # Check if the directory exists
    unless Dir.exist?(@root_dir)
      puts "Error: Directory #{@root_dir} does not exist."
      return
    end

    # Find all files in the directory and sort them into subfolders
    Find.find(@root_dir) do |path|
      next if File.directory?(path)

      file_type = determine_file_type(path)
      unless file_type
        puts "Warning: Skipping file #{path}, unknown type."
        next
      end

      destination_dir = File.join(@root_dir, file_type)
      create_directory(destination_dir) unless Dir.exist?(destination_dir)

      FileUtils.mv(path, destination_dir)
      puts "Moved #{path} to #{destination_dir}"
    end
  end

  private

  # Determine the file type based on extension
  def determine_file_type(path)
    extension = File.extname(path)[1..-1].downcase
    case extension
    when 'txt', 'md', 'log'
      'Documents'
    when 'jpg', 'jpeg', 'png', 'gif'
      'Images'
    when 'mp3', 'wav', 'wma'
      'Audio'
    when 'mp4', 'avi', 'mov'
      'Videos'
    when 'pdf'
      'PDFs'
    when 'doc', 'docx', 'odt'
      'WordDocuments'
    when 'xls', 'xlsx', 'ods'
      'Spreadsheets'
    else
      nil
    end
  end

  # Create a directory if it does not exist
  def create_directory(dir)
    FileUtils.mkdir_p(dir)
    puts "Created directory #{dir}"
  end
end

# Example usage:
if __FILE__ == $0
  # Change 'your_directory_path' to the path of the directory you want to organize
  organizer = FolderOrganizer.new('your_directory_path')
  organizer.organize
end