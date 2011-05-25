require "spec_helper"

describe Parser do
  
  it "should parse --dir, --name, --type, --user, --maxdepth and return as params" do
    parser = Parser.new(['./', '--name', '.*\.js$', '--type', 'f', '--user', 'Bart Simpson', '--maxdepth', '2'])
    parser.to_params.should == {:dir => './', :name => '.*\.js$', :type => 'f', :owner => 'Bart Simpson', :max_depth => '2'}
  end

  it "should parse -d, -n, -t, -u, -md and return as params" do
    parser = Parser.new(['./', '-n', '.*\.js$', '-t', 'f', '-u', 'Bart Simpson', '-md', '2'])
    parser.to_params.should == {:dir => './', :name => '.*\.js$', :type => 'f', :owner => 'Bart Simpson', :max_depth => '2'}
  end
  
end