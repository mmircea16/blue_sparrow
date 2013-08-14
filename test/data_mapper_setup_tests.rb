host = 'ec2-54-221-204-45.compute-1.amazonaws.com'
db = 'dfp7kkrs2jpfbd'
user = 'itsdqcvsskosll'
password = 'nW1SZg4BxyBtDCnXE00hqeagGk'

DataMapper.setup :default, "postgres://#{user}:#{password}@#{host}/#{db}"
DataMapper.finalize