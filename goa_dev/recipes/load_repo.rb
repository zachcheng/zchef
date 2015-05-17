source_path = node[:source][:path]
source_user = node[:source][:user]
repository_host  = node[:source][:repository_host]
repository_ssh_private_key = node[:deploy]['gemsapp'][:scm][:ssh_key]
repository_ssh_private_key_path = '/tmp/id_rsa_gems'
ssh_wrapper_path = '/tmp/ssh_wrapper.sh'

template ssh_wrapper_path do
  source 'chef_deploy_ssh_wrapper.erb'
  variables :ssh_key_path => repository_ssh_private_key_path
  action :create
end

directory source_path do
  owner source_user
  action :create
  recursive true
end

git source_path do
  action :sync
  repository repository_host
  enable_submodules true
  ssh_wrapper ssh_wrapper_path
end 

execute "checkout master branch on repo" do
  cwd "#{source_path}"
  command "git checkout master"
end 

file repository_ssh_private_key_path do
  action :delete
end


