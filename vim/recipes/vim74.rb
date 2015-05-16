tmp_directory = '/tmp/vim74'

remote_file '/tmp/vim74.tar.bz2' do
  source "http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2"
  action :create_if_missing
end

execute 'unpack vim.tar.bz2' do
  command "tar -xvf vim74.tar.bz2"
  cwd '/tmp'
end

execute 'configure' do
  command <<-EOF.gsub /^\s+/, ""
    ./configure --with-features=huge --enable-rubyinterp \
      --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7-config \
      --enable-gui=gtk2 --enable-cscope --prefix=/usr
  EOF
  cwd tmp_directory
end

execute 'make' do
  command 'make VIMRUNTIMEDIR=/usr/share/vim/vim74'
  cwd tmp_directory
end

execute 'make install' do
  command 'make install'
  cwd tmp_directory
end
