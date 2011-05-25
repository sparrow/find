SPEC_DIR = File.dirname(__FILE__)
lib_path = File.expand_path("#{SPEC_DIR}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

require 'find'
include Find

RSpec.configure do |config|
end

def create_full_path paths
  paths.map do |path|
    SPEC_DIR + '/' + path
  end
end

def find_directories_result
  directories = ["factories/public", "factories/public/images", "factories/public/images/icons", "factories/public/images/jquery", "factories/public/images/open_id", "factories/public/javascripts", "factories/public/javascripts/admin", "factories/public/javascripts/common"]
  create_full_path directories
end

def find_directories_with_co_in_name_result
  directories = ["factories/public/images/icons", "factories/public/javascripts/common"]
  create_full_path directories
end

def find_files_in_public_images_result
  files = ["factories/public/images/icons/blue_bottom_corner.png", "factories/public/images/icons/blue_check.png", "factories/public/images/icons/buck.png", "factories/public/images/jquery/popup-close.gif", "factories/public/images/jquery/slider.png", "factories/public/images/open_id/facebook_32.png", "factories/public/images/open_id/google_32.png", "factories/public/images/open_id/openid_32.png", "factories/public/images/open_id/yahoo_32.png"]
  create_full_path files
end

def find_symbolic_links_result
  links = ["factories/public/jquery_images"]
  create_full_path links
end

def find_by_name_started_on_blue_result
  files = ["factories/public/images/icons/blue_bottom_corner.png", "factories/public/images/icons/blue_check.png"]
  create_full_path files
end

def all_files
  files = ["factories/public", "factories/public/images", "factories/public/images/icons", "factories/public/images/icons/blue_bottom_corner.png", "factories/public/images/icons/blue_check.png", "factories/public/images/icons/buck.png", "factories/public/images/jquery", "factories/public/images/jquery/popup-close.gif", "factories/public/images/jquery/slider.png", "factories/public/images/open_id", "factories/public/images/open_id/facebook_32.png", "factories/public/images/open_id/google_32.png", "factories/public/images/open_id/openid_32.png", "factories/public/images/open_id/yahoo_32.png", "factories/public/javascripts", "factories/public/javascripts/admin", "factories/public/javascripts/admin/categories.js", "factories/public/javascripts/common", "factories/public/javascripts/common/inline_editing.js", "factories/public/javascripts/facebook.js", "factories/public/jquery_images", "factories/public/robots.txt"]
  create_full_path files
end

def find_with_max_depth_2_result
  files = ["factories/public", "factories/public/images", "factories/public/images/icons", "factories/public/images/jquery", "factories/public/images/open_id", "factories/public/javascripts", "factories/public/jquery_images", "factories/public/robots.txt"]
  create_full_path files
end

def find_js_files_result
  files = ["factories/public/javascripts/admin/categories.js", "factories/public/javascripts/common/inline_editing.js", "factories/public/javascripts/facebook.js"]
  create_full_path files
end