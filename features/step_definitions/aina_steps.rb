When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

When /^I succesfully run "([^"]*)"$/ do |command|
	step %(I run `#{command}`)
end

Given /^the file "(.*?)" doesn't exist$/ do |file|
	FileUtils.rm(file) if File.exists? file
end

Given /^the file "(.*?)" exists$/ do |file|
	File.exists? file
end

Then /^aina should be installed$/ do
	@home = Dir.pwd + '/tmp/aruba'
	step %(a file named "#{@home}/inc/aina.php" should exist)
end