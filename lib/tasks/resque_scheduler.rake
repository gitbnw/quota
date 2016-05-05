 # resque_scheduler.rake
 # Resque tasks
require 'resque/tasks'
require 'resque/scheduler/tasks'

 namespace :resque do
   task :setup do
     require 'resque'
     require 'resque/scheduler'
 
     # you probably already have this somewhere
     Resque.redis = 'localhost:6379'
     
 

   end
 end