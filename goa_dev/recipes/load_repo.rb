source_path = node[:source][:path]
source_user = node[:source][:user]
repository_host  = node[:source][:repository_host]

directory source_path do
  owner source_user
  action :create
  recursive true
end

git source_path do
  action :sync
  repository repository_host
  enable_submodules true
end 

execute "checkout master branch on repo" do
  cwd "#{source_path}"
  command "git checkout master"
end 

