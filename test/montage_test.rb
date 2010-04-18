require 'test/unit'
require File.join(File.dirname(__FILE__), '../lib/mini_magick')

class Montage < Test::Unit::TestCase
  include MiniMagick

  CURRENT_DIR = File.dirname(File.expand_path(__FILE__)) + "/"

  TOP_IMAGE_PATH = CURRENT_DIR + "simple.gif"
  BOTTOM_IMAGE_PATH = CURRENT_DIR + "leaves.tiff"
  OUTPUT_FORMAT = 'jpg'

  def test_montage_from_images
    begin
      image1 = Image.open(TOP_IMAGE_PATH)
      image2 = Image.open(BOTTOM_IMAGE_PATH)
      output_path = CURRENT_DIR + 'montage.jpg'
      output_image = Montage.new([image1, image2], OUTPUT_FORMAT)
      
      assert_equal output_image.class, MiniMagick::Image
      
      output_image.write(output_path)
      
      assert File.exists?(output_path)
      assert_match(/^jpeg$/i, output_image[:format])
    ensure
      File.delete output_path
    end
  end
  
end
