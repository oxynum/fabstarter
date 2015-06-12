# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'fabstarter'
set :repo_url, 'git@github.com:oxynum/fabstarter.git'
set :deploy_to, '/home/deploy/geronimo'
set :deploy_user, 'deploy'

set :assets_roles, [:web, :app]
set :migration_role, :app
# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.rbenv-vars')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :parallel, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
end

namespace :db do 
  desc "Migrate database"
  task :migrate do 
    on roles(:app), in: :parallel, wait: 5 do |role|
      rails_env = fetch(:rails_env)
      within current_path do 
        rake "db:migrate RAILS_ENV=production"
      end
    end
  end

  task :seed do
    on roles(:app), in: :parallel, wait: 5 do |role|
      rails_env = fetch(:rails_env)
      within current_path do
        rake "db:seed RAILS_ENV=production"
      end
    end
  end
end

namespace :rails do
  desc "Start a rails console, for now just with the primary server"
  task :c do
    on roles(:app), primary: true do |role|
      rails_env = fetch(:rails_env)
      execute_remote_command_with_input "#{bundle_cmd_with_rbenv} #{current_path}/script/rails console #{rails_env}"
    end
  end

  def execute_remote_command_with_input(command)
    port = fetch(:port) || 22
    puts "opening a console on: #{host}...."
    cmd = "ssh -l #{fetch(:deploy_user)} #{host} -p #{port} -t 'cd #{deploy_to}/current && #{command}'"
    exec cmd
  end
end

def bundle_cmd_with_rbenv
  if fetch(:rbenv_ruby)
    "RBENV_VERSION=#{fetch(:rbenv_ruby)} RBENV_ROOT=#{fetch(:rbenv_path)}  #{File.join(fetch(:rbenv_path), '/bin/rbenv')} exec bundle exec"
  else
    "ruby "
  end
end

after :deploy, "db:migrate"
after :deploy, "db:seed"
after :deploy, "deploy:restart"