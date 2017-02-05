
# This is a fix for rbenv and cron
env :PATH, '/home/advicy/bin:/home/advicy/.local/bin:/home/advicy/.rbenv/shims:/home/advicy/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games'
set :output, " /home/advicy/apps/advicy/current/log/cron.log"

every 1.day, at: '5:30am' do
  rake "sitemap:refresh"
end

