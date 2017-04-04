require 'net/ssh/proxy/command'

# config valid only for current version of Capistrano
lock '3.8.0'

set :scm, :copy
set :application, 'thundermole'
# set :repo_url, 'git@github.com:nextdayproperty/nested-web-front-end.git'
set :deploy_to, '/home/applications/thundermole'

# Configure Capistrano to use the bastion host as a proxy
ssh_command = "ssh applications@dc1-live-data1.srv.external.nested.com -W %h:%p"

set :ssh_options, {
  proxy: Net::SSH::Proxy::Command.new(ssh_command),
  forward_agent: true
}

namespace :deploy do
  task :restart do
    on roles(:app) do
      # execute 'PM2_HOME=/home/applications /usr/bin/pm2 restart nested-web-front-end'
    end
  end
  after :publishing, :restart
end
