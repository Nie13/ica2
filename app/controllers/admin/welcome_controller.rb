class Admin::WelcomeController < Admin::BaseController
  def index
  end

  def restart_sidekiq
    `sidekiqctl stop #{Rails.root.join('tmp/pids/sidekiq.pid').to_s}`
    `cd #{Rails.root.to_s} && ( RAILS_ENV=#{Rails.env} bundle exec sidekiq --index 0 --pidfile #{Rails.root.join('../..','shared/tmp/pids/sidekiq.pid')} --environment #{Rails.env} --logfile #{Rails.root.join('../..','shared/log/sidekiq.log')} --daemon )`
    render :js => "alert('restart successfully');$('.btn').attr('disabled', false)"
  end
end
