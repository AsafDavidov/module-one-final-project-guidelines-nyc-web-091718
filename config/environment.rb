require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_relative '../lib/cli_methods.rb'
require_all 'app'
require_all 'csv'

ActiveRecord::Base.logger = nil
