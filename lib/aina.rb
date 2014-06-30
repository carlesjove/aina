# Lib
Dir.glob(File.dirname(__FILE__) + "/aina/*.rb") { |file|  require file }
Dir.glob(File.dirname(__FILE__) + "/aina/generable/*.rb") { |file|  require file }
Dir.glob(File.dirname(__FILE__) + "/aina/generable/types/*.rb") { |file|  require file }

# Templates
Dir.glob(File.expand_path('..') + "/templates/*") { |file|  require file }

module Aina
	def self.aina_version
		Aina::VERSION
	end

	def self.install(output = false)
		unless Dir.exists?(Dir.pwd + '/inc')
			Dir.mkdir(Dir.pwd + '/inc')
		end

		# Install Aina
		unless self.is_installed?
			text = File.read(Aina::TEMPLATES_DIR + '/aina_framework.php')

			['{{aina_version}}'].each do |replace|
				attribute = replace.gsub(/[{}]/, '')
				@output = text.gsub!(/#{replace}/, self.send(attribute))
			end

			File.open(Dir.pwd + "/inc/aina.php", "w") {|file| file.puts @output}

			message = "Aina has been installed in your WordPress theme.\n"
			message += "\n\nIf you want your post type to be automatically included, put this is functions.php:\n"
	    message += "function aina_post_types() {\n"
	    message += " return array('your_post_type', 'another_post_type', 'etc');\n"
	    message += "}\n"
		else
			message = "Aina was already installed in your WordPress theme ;-)\n"
		end

		# Include Aina
		unless functions_php_exists?
			create_empty_functions_php
		end
		File.open(functions_php, "a+") {|file| file.puts aina_inclusion}

		if output
	    puts message
	  end
	end

	def self.is_installed?
		File.exists?(Dir.pwd + "/inc/aina.php")
	end
end
