developer = node[:developers][node[:opsworks][:instance][:hostname]] || 'zdefault'

execute "get keys for RVM installation" do
  cwd "/home/#{developer}"
  environment ({ 'GNUPGHOME' => "/home/#{developer}"})
  user "#{developer}"
  command "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
end 

execute "install RVM for single user" do
  cwd "/home/#{developer}"
  environment ({'HOME' => "/home/#{developer}", 'USER' => developer})
  command "curl -sSL https://get.rvm.io | bash -s stable"
  user "#{developer}"
end 

execute "install ruby 2.2.2 for single user" do
  cwd "/home/#{developer}"
  environment ({'HOME' => "/home/#{developer}", 'USER' => developer})
  command "rvm install 2.2.2"
  user "#{developer}"
end

