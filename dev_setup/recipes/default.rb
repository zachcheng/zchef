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
  command <<-EOH
    curl -sSL https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    ~/.rvm/bin/rvm install 2.2.2
  EOH
  user "#{developer}"
end

execute "--no-rdoc --no-ri for gems" do
  cwd "/home/#{developer}"
  environment ({'HOME' => "/home/#{developer}", 'USER' => developer})
  command <<-EOH
    echo 'gem: --no-document' >> .gemrc
  EOH
  user "#{developer}"
end 
