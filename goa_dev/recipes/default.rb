source_path = node[:source][:path]
source_container_path = node[:source][:container_path]
source_user = node[:source][:user]
repository_host  = node[:source][:repository_host]
repository_ssh_private_key = node[:deploy]['gemsapp'][:scm][:ssh_key]
repository_ssh_private_key_path = '/tmp/id_rsa_gems'
ssh_wrapper_path = '/tmp/ssh_wrapper.sh'

# create the ssh key file
template repository_ssh_private_key_path do
  source 'ssh_key.erb'
  variables :key => repository_ssh_private_key
  action :create
  mode 0700
  user source_user
end

# create the ssh wrapper
template ssh_wrapper_path do
  source 'chef_deploy_ssh_wrapper.erb'
  variables :ssh_key_path => repository_ssh_private_key_path
  action :create
  mode 0700
  user source_user
end

#create src directory to place repo in
directory source_container_path do
  owner source_user
  action :create
end

#create goa directory to place repo in
directory source_path do
  owner source_user
  action :create
end

#pull the repo
git source_path do
  action :sync
  repository repository_host
  enable_submodules true
  ssh_wrapper ssh_wrapper_path
  user source_user
end 

execute "checkout master branch on repo" do
  cwd "#{source_path}"
  command "git checkout master"
end 

# delete the key file
file repository_ssh_private_key_path do
  action :delete
end

# delete the wrapper file
file ssh_wrapper_path do
  action :delete
end

execute "Create and use the correct gemset for the app" do
  cwd source_path
  environment ({'HOME' => "/home/#{source_user}", 'USER' => source_user})
  command <<-EOH
    ~/.rvm/bin/rvm use 2.2.2@goa --create
  EOH
  user "#{source_user}"
end
