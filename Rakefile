require_relative 'config/environment'

desc 'starts a console'
task :console do
  Pry.start
end

desc 'creates and populates database'
task :seed do
  require_relative "./db/seed.rb"
end

desc 'run queries'
task :queries do
  require_relative "./run"
end
