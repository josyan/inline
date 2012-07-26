require "bundler/capistrano"

set :application, "inline"
set :repository,  "git://github.com/josyan/inline.git"

set :bundle_dir, "#{release_path}/vendor/bundle"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "quotations.glass-vision.net"                          # Your HTTP server, Apache/etc
role :app, "quotations.glass-vision.net"                          # This may be the same as your `Web` server
role :db,  "quotations.glass-vision.net", :primary => true

set :deploy_to, '/home/glass/apps/inline'
set :user, 'glass'
set :use_sudo, false

namespace(:inline) do
  task :symlink, :roles => :web do
    run <<-CMD
      ln -nfs #{shared_path}/public/system #{release_path}/public/system
    CMD
  end
end
after "deploy:symlink", "inline:symlink"
