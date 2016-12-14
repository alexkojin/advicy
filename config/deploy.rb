require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/systemd'

set :domain, 'advicy'
set :deploy_to, '/home/advicy/apps/advicy'
set :repository, 'git@github.com:alexkojin/advicy.git'
set :branch, 'master'
set :rails_env, 'production'
set :user, 'advicy'

set :shared_dirs, ['vendor/bundle', 'public', 'log', 'tmp/cache', 'tmp/pids', 'tmp/sockets']
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/application.yml', 'config/puma.rb')

task :environment do
  invoke :'rbenv:load'
end

task setup: :environment do
  command %[mkdir -p "#{fetch(:shared_path)}/config"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/config"]

  comment %{Be sure to add 'database.yml', 'application.yml' and 'puma.rb' in '#{fetch(:shared_path)}/config/' directory}
end

task :build do
  run :local do
    in_path('frontend') do
      command %{ng build --prod --aot}
    end
  end
end

desc "Deploys the current version to the server."
task deploy: :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    # invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'systemctl:restart', 'advicy-puma'
    end
  end
end
