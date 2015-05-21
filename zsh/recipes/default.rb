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

  template "/home/#{developer}/.zprofile" do
    source "zprofile.erb"
    owner developer
    group 'opsworks'
    action :create_if_missing
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

  execute "set zsh as default shell for developer" do
    command "chsh -s #{`which zsh`.strip} #{developer}"
    user 'root'
  end

  execute 'root shell setup: symlink .zshrc in /root to developer .zshrc file' do
    command "ln -snf /home/#{developer}/.zshrc /root/.zshrc"
    user 'root'
  end

  execute 'root shell setup: symlink .oh-my-zsh in /root to developer .oh-my-zsh directory' do
    command "ln -snf /home/#{developer}/.oh-my-zsh /root/.oh-my-zsh"
    user 'root'
  end

  execute 'root shell setup: make zsh default root shell' do
    command "chsh -s #{`which zsh`.strip} root"
    user 'root'
  end

end
