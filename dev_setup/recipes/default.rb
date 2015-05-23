developer = node[:developers][node[:opsworks][:instance][:hostname]] || 'zdefault'

execute "get keys for RVM installation" do
  cwd "/home/#{developer}"
  command "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
  user developer
end 

execute "install RVM for single user" do
  cwd "/home/#{developer}"
  command "curl -sSL https://get.rvm.io | bash -s stable"
  user developer
end 

