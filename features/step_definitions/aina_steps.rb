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
	@home = Dir.pwd + '/tmp/aruba'
	# Create dirs if necessary
	parts = file.split('/')
	i = 0
	while i < ( parts.count - 1 )
		FileUtils.mkdir @home + parts[i] unless Dir.exists?(@home + parts[i])
		i += 1
	end
	# Create the file
	FileUtils.touch(@home + file) unless File.exists? @home + file
end

Then /^aina should be installed$/ do
	@home = Dir.pwd + '/tmp/aruba'
	step %(a file named "#{@home}/inc/aina.php" should exist)
end