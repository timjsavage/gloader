if node.attribute?('rackspace')

  # The kernel on the Rackspace Fedora 16 image is not compiled with SELinux support.
  # Review - coming soon.
  # http://www.rackspace.com/blog/selinux-and-other-linux-image-updates/

  %w{
    selinux-policy-targeted selinux-policy libselinux libselinux-python
    libselinux-utils policycoreutils setroubleshoot setroubleshoot-server
    setroubleshoot-plugins
  }.each{|pkg| package pkg}

  file "/usr/bin/runcon" do
    content %q{
#!/bin/bash
while (( "$#" )); do
  if [[ "$1" == "-l" || "$1" == *"s0"* ]]; then
    shift
  else
    break
  fi
done
eval $@
    }.strip
  end

  file "/usr/bin/chcon" do
    content ""
  end

  execute "sed -i 's/actual_context = .*//' /usr/bin/ss-trap-user"
  execute "sed -i 's/target_context != actual_context/False/' /usr/bin/ss-trap-user"

end
