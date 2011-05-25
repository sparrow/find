require "spec_helper"

describe Finder do

  context "#find" do
    it "should find directories" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'd')
      finder.find.should == find_directories_result
    end

    it "should find files" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories/public/images', :type => 'f')
      finder.find.should == find_files_in_public_images_result
    end

    it "should find symbolic links" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'l')
      finder.find.should == find_symbolic_links_result
    end

    it "should find by name '^blue'" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :name => '^blue')
      finder.find.should == find_by_name_started_on_blue_result
    end

    it "should find by owner" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :owner => Etc.getpwuid(File.lstat(__FILE__).uid).name)
      finder.find.should == all_files
    end

    it "should find with max depth 2" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :max_depth => 2)
      finder.find.should == find_with_max_depth_2_result
    end
  end
  
  context "#to_s" do
    it "should return results with newline separated" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :max_depth => 2)
      finder.find
      finder.to_s.should == find_with_max_depth_2_result.join("\n")
    end
  end
  
  context "#name?" do
    it "should be true with 'jquery.js' name" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :name => '.*\.js$')
      finder.send(:name?, 'jquery.js').should be_true
    end

    it "should not be true with 'public' name" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :name => '.*\.js$')
      finder.send(:name?, 'public').should_not be_true
    end

    it "should be true with no name defined" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'l')
      finder.send(:name?, 'public').should be_true
    end
  end
  
  context "#type?" do
    it "should be true with type 'f' for file" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'f')
      finder.send(:type?, SPEC_DIR + '/factories/public/images/icons/buck.png').should be_true
    end

    it "should not be true with type 'f' for not file" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'f')
      finder.send(:type?, SPEC_DIR + '/factories/public/images/icons').should_not be_true
      finder.send(:type?, SPEC_DIR + 'factories/public/jquery_images').should_not be_true
    end

    it "should be true with type 'd' for directory" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'd')
      finder.send(:type?, SPEC_DIR + '/factories/public/images').should be_true
    end

    it "should not be true with type 'd' for not directory" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'd')
      finder.send(:type?, SPEC_DIR + '/factories/public/images/icons/buck.png').should_not be_true
      finder.send(:type?, SPEC_DIR + 'factories/public/jquery_images').should_not be_true
    end

    it "should be true with type 'l' for symbolic link" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'l')
      finder.send(:type?, SPEC_DIR + '/factories/public/jquery_images').should be_true
    end

    it "should not be true with type 'l' for not symbolic link" do
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'l')
      finder.send(:type?, SPEC_DIR + '/factories/public/images/icons/buck.png').should_not be_true
      finder.send(:type?, SPEC_DIR + 'factories/public/images').should_not be_true
    end

    it "should be true without type" do
      file_path = SPEC_DIR + '/factories/public/images/icons/buck.png'
      finder = Finder.new(:dir => SPEC_DIR + '/factories')
      finder.send(:type?, SPEC_DIR + '/factories/public/jquery_images').should be_true
    end
  end
  
  context "#owner?" do
    it "should be true with correct owner" do
      file_path = SPEC_DIR + '/factories/public/images/icons/buck.png'
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :owner => Etc.getpwuid(File.lstat(file_path).uid).name)
      finder.send(:owner?, file_path).should be_true
    end

    it "should not be true with not correct owner" do
      file_path = SPEC_DIR + '/factories/public/images/icons/buck.png'
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :owner => 'Bart Simpson')
      finder.send(:owner?, file_path).should_not be_true
    end

    it "should be true without owner" do
      file_path = SPEC_DIR + '/factories/public/images/icons/buck.png'
      finder = Finder.new(:dir => SPEC_DIR + '/factories', :type => 'l')
      finder.send(:owner?, file_path).should be_true
    end
  end
  
end