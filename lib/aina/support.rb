def is_wordpress_theme?
	theme_path = Dir.pwd.split('/')
	theme_path.pop
	theme_path.last(2).join('/') == 'wp-content/themes'
end

def functions_php
	Dir.pwd + "/functions.php"
end

def functions_php_exists?
  File.exists?(Dir.pwd + "/functions.php")
end

def create_empty_functions_php
	unless functions_php_exists?
		File.open(functions_php, "w") {|file| file.puts "<?php\n"}
	end
end

def aina_inclusion
	output = "\n/**\n"
	output += " * Include Aina's framework\n"
	output += " */\n"
	output += "if ( file_exists('inc/aina.php') ) {\n"
	output += "	require_once 'inc/aina.php';\n"
	output += "}\n"
end

class String
	def camelcase
		r = Array.new

		pieces = self.split(' ')
		pieces = self.split('_') unless pieces.length > 1

		pieces.each do |p|
			r << p.capitalize
		end
		r.join()
	end
end
