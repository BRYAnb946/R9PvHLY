# 代码生成时间: 2025-09-21 18:43:48
# Image Resizer using Ruby and CUBA framework
# This script resizes images in batch.

require 'cuba'
require 'mini_magick'
require 'fileutils'

# Define the app
Cuba.define do
  # Error handling for file not found
  on condition do |res|
    res.file not_path('').to_s.empty?
  end do
    res.flash[:error] = 'No file specified or file not found'
    res.redirect('/')
  end

  # Route for uploading and resizing images
  on get do
    # Render the form for uploading images
    res.write <<-HTML
    <html>
      <body>
        <form action="/upload" method="post" enctype="multipart/form-data">
          <input type="file" name="image" />
          <input type="submit" value="Upload and Resize" />
        </form>
      </body>
    </html>
    HTML
  end

  # Route for processing the upload and resizing
  on post, path: '/upload' do
    # Check if the file was uploaded
    raise 'No file uploaded' unless params['image']

    # Save the uploaded file
    uploaded_file = params['image'][:tempfile]
    filename = params['image'][:filename]
    new_filename = "#{Time.now.to_i}_#{filename}"
    FileUtils.cp(uploaded_file.path, "./uploads/#{new_filename}")

    # Resize the image
    begin
      image = MiniMagick::Image.open("./uploads/#{new_filename}")
      # Define the new size or provide a method to calculate it
      new_size = '800x600' # Example size
      image.resize(new_size)
      image.write("./resized/#{new_filename}")
      res.flash[:notice] = 'Image uploaded and resized successfully'
    rescue MiniMagick::Error => e
      res.flash[:error] = "Failed to resize image: #{e.message}"
    end

    # Redirect to the form after processing
    res.redirect('/')
  end

  # Route to display the original and resized images
  on get, path: '/images' do
    # List all files in the uploads and resized directories
    original_images = Dir.glob('./uploads/*')
    resized_images = Dir.glob('./resized/*')

    # Render the images
    res.write <<-HTML
    <html>
      <head><title>Original and Resized Images</title></head>
      <body>
        <h2>Original Images:</h2>
        <ul>
        #{original_images.map { |img| "<li><img src='" + img + "' width='200' /></li>" }.join("\
")}
        </ul>
        <h2>Resized Images:</h2>
        <ul>
        #{resized_images.map { |img| "<li><img src='" + img + "' width='200' /></li>" }.join("\
")}
        </ul>
      </body>
    </html>
    HTML
  end

  # Run the Cuba app
  run!
end