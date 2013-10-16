describe_recipe "openshift::broker" do

  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it "disables SE-Linux" do
    refute se_linux_enabled?
  end

  it "creates an openshift user to use for the install" do
    user("openshift").must_exist
  end

  it "exposes a REST API" do
    api_entry_point_response.must_include 'API entry point'
  end

  it "is running the mcollective daemon to communicate with nodes" do
    service("mcollective").must_be_running
  end

  it "is running an AMQP daemon to distribute messages to the nodes" do
    assert listening_on_port?(5672)
  end

  it "creates a user in the mongo collection for each defined user" do
    created_users = openshift_auth_users
    (node['openshift']['users'] - created_users).must_be_empty
  end

  def api_entry_point_response
    %x{curl -k 'https://localhost/broker/rest/api'}.strip
  end

  def listening_on_port?(port)
    %x{lsof -i :#{port} > /dev/null}
    $?.success?
  end

  def openshift_auth_users
    %x{mongo stickshift_broker_dev --eval 'db.auth_user.find().forEach(printjson)' | grep '_id' | awk -F '"' '{print $(NF-1)}'}.strip.split("\n")
  end

  def se_linux_enabled?
    %x{getenforce}.strip == 'Enforcing'
  end

end
