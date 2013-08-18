host = ENV['host']
db = ENV['db']
user = ENV['user']
password = ENV['password']

DataMapper.setup :default, "postgres://#{user}:#{password}@#{host}/#{db}"
DataMapper.finalize