describe_recipe "openshift::node" do

  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it "is running the mcollective daemon to communicate with the broker" do
    service("mcollective").must_be_running
  end

end
