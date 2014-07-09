require 'aruba/cucumber'
require 'fileutils'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s

  # Set a tmp HOME for tests, and clean it
  @real_home = ENV['HOME']
  fake_home = File.join('tmp/aruba')
  FileUtils.rm_rf fake_home, secure: true
  ENV['HOME'] = fake_home	
end

After do
  ENV['RUBYLIB'] = @original_rubylib
  # Set HOME back to it's original dir !
  ENV['HOME'] = @real_home
end
