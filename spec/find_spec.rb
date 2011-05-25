require "spec_helper"

describe "find from command line" do

  def find_bin_path
    bin_path = File.expand_path("#{SPEC_DIR}/../bin")
    bin_path + '/find'
  end

  it "should find directories" do
    `#{find_bin_path} #{SPEC_DIR + '/factories'} --type d`.chomp.should == find_directories_result.join("\n")
  end

  it "should find directories with 'co' in name" do
    `#{find_bin_path} #{SPEC_DIR + '/factories'} --type d --name co`.chomp.should == find_directories_with_co_in_name_result.join("\n")
  end

  it "should find js files" do
    `#{find_bin_path} #{SPEC_DIR + '/factories'} --type f --name .*\.js$`.chomp.should == find_js_files_result.join("\n")
  end

  it "should find symbolic links" do
    `#{find_bin_path} #{SPEC_DIR + '/factories'} --type l`.chomp.should == find_symbolic_links_result.join("\n")
  end

end