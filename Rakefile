task :default => [:setup]

desc %(Make ~/.vim/tmp and ~/.vim/backup dirs)
task :tmp_dirs do
  print "create backup and tmp dirs..."
  mkdir_p "backup"
  mkdir_p "tmp"
  puts "done."
end

desc %(Bring vundle and bundles up to date)
task :bundles do
  print "update vundle..."
  `git submodule sync >/dev/null`
  `git submodule update --init`
  puts "done."
  print "update/install bundles..."
  `vim +BundleInstall +qall`
  puts "done."
end

desc %(Make ~/.vimrc and ~/.gvimrc symlinks)
task :link do
  print "create links..."
  %w[vimrc mvimrc].each do |script|
    dotfile = File.join(ENV['HOME'], ".#{script}")
    if File.exist? dotfile
      warn "~/.#{script} already exists"
    else
      ln_s File.join('.vim', script), dotfile
    end
  end
  puts "done."
end

desc %(Quick setup: create links, tmp/backup dirs, install bundles)

task :setup do
  Rake::Task["tmp_dirs"].execute
  Rake::Task["link"].execute
  Rake::Task["bundles"].execute
end


