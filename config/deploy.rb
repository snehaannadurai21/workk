# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"

set :application, "bookhold"
set :repo_url, "https://github.com/snehaannadurai21/work.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/bookhold"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
set :keep_releases, 5

set :puma_threads, [4, 16]
set :puma_workers, 4
set :puma_bind, "unix://#{fetch(:deploy_to)}/shared/tmp/sockets/puma.sock"

set :puma_state, "#{shared_path}/tmp/sockets/puma.state"
set :puma_preload_app, true

# Restart Puma after deployment
namespace :puma do
  desc 'Restart Puma'
  task :restart do
    on roles(:app) do
      execute "sudo systemctl restart puma_#{fetch(:application)}_#{fetch(:stage)}"
    end
  end
end

# Define tasks to restart Puma after certain events
after 'deploy:publishing', 'puma:restart'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
