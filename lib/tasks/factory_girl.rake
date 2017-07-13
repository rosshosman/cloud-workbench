# Linting factories: https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#linting-factories
namespace :factory_girl do
  desc 'Verify that all FactoryGirl factories are valid'
  task lint: :environment do
    if Rails.env.test?
      begin
        DatabaseCleaner.start
        FactoryGirl.lint
      ensure
        DatabaseCleaner.clean
      end
    else
      system("bin/rake factory_girl:lint RAILS_ENV='test'")
    end
  end
end
