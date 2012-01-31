task :default => [:tmp_dirs, :bundles, :link]

task :tmp_dirs do
  mkdir_p "backup"
  mkdir_p "tmp"
end

desc %(Bring bundles up to date)
task :bundles do
  sh "vim +BundleInstall +qall"
end

desc %(Make ~/.vimrc and ~/.gvimrc symlinks)
task :link do
  %w[vimrc gvimrc].each do |script|
    dotfile = File.join(ENV['HOME'], ".#{script}")
    if File.exist? dotfile
      warn "~/.#{script} already exists"
    else
      ln_s File.join('.vim', script), dotfile
    end
  end
end


