developer = node[:developers][node[:opsworks][:instance][:hostname]] || 'zdefault'

if developer
  package 'zsh' do
    action :install
  end

  git "/home/#{developer}/.oh-my-zsh" do
    repository 'git://github.com/robbyrussell/oh-my-zsh.git'
    not_if { File.directory? "/home/#{developer}/.oh-my-zsh"  }
  end

  execute 'change oh-my-zsh owner' do
    command "chown -R #{developer}:nginx /home/#{developer}/.oh-my-zsh"
  end

  template "/home/#{developer}/.zshrc" do
    source "zshrc.erb"
    owner developer
    group 'opsworks'
    action :create_if_missing
  end

  template "/home/#{developer}/.oh-my-zsh/themes/prose.zsh-theme" do
    source "prose.zsh-theme.erb"
    owner developer
    group 'opsworks'
    action :create
  end
end
