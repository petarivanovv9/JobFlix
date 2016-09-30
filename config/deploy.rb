# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'gryphon'

set :scm, :git
set :repo_url, 'git@github.com:pepincho/Gryphon.git'
set :deploy_via, :remote_cache

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'dockerization'
# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '~/gryphon'

# Default value for :pty is false
# set :pty, true
set :format, :pretty

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :docker do
  task :compose_up do
    on roles(:docker) do
      puts "================Start All containers===================="
      execute "cd #{deploy_to}/current && docker-compose -p gryphon up --build -d"
    end
  end

  task :compose_stop do
    on roles(:docker) do
      puts "================Stop All containers===================="
      execute "cd #{deploy_to}/current && docker-compose -p gryphon stop && docker-compose -p gryphon rm -f"
      execute 'docker rmi $(docker images --quiet --filter "dangling=true")', raise_on_non_zero_exit: false
    end
  end

  task :compose_build do
    on roles(:docker) do
      puts "================Build All containers===================="
      execute "cd #{deploy_to}/current && docker-compose -p gryphon build"
    end
  end
end

before "deploy:starting", "docker:compose_stop"
after "deploy:finished", "docker:compose_up"