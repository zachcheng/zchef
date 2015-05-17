hostname = node[:opsworks][:instance][:hostname]
default[:source][:user] = node[:developers][hostname] || 'zdefault'
default[:source][:path] = "/home/src"
default[:source][:repository_host] = "git@bitbucket.org:zachcheng/goa.git"
