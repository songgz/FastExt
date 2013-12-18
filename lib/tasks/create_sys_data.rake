# encoding: utf-8
#desc "Explaining what the task does"
namespace :fast_ext do
  desc "create system_data include all task"
  task :create_sys_data => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["app:fast_ext:init"].invoke
  end
end