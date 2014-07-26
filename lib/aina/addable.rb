class Addable
	attr_accessor :name, :aina_version, :fields

	def initialize(name, fields = nil)
		@type = 'post_type'
		@name = validate_name(name)
		@aina_version = Aina::VERSION

		parse_fields(fields)
	end

	def parse_fields(fields)
		@fields = Array.new
		fields.each do |f|
			a = f.split(':')
			# TODO: Validate type against a whitelist
			unless a[1].nil?
				@fields << {key: a[0], type: a[1]}
			else
				raise Exception, "Type was missing for #{a[0]}"
			end
		end
	end

	def fields_php_array
		a = ''
		@fields.each do |f|
			a += "'#{f[:key]}' => array(\n"
			a += "  'label'     => '#{f[:key].capitalize}',\n"
			a += "  'type'      => '#{f[:type]}',\n"
			a += "  'options' 	=> array( 'option_1' => __('Option One'), 'option_2' => __('Option One') ),\n" if %w(radio checkbox select).include?(f[:type])
			a += "),\n"
		end
		a
	end

	def custom_fields
		c = Array.new
		c << "/**"
		c << " * Custom data fields"
		c << " * Add these custom fields to the #{@name} post type"
		c << " * IMPORTANT: Thou shalt not rename this function, or bad things may happen"
		c << " */"
		c << "if ( ! function_exists( '#{@name}_custom_fields' ) ) {"
		c << " function #{@name}_custom_fields() {"
		c << "	 return array("
		c << "     #{fields_php_array}"
		c << "	 );"
		c << " }"
		c << "}"
		c.join("\n")
	end

	def add_custom_fields
		@file = Dir.pwd + "/post-types/#{@name}.php"
		
		# The post type wasn't using custom fields yet, 
		# so wrap them with the custom_fields function
		unless File.read(@file).include? "function #{@name}_custom_fields"
			File.open(@file, 'a+') {|file| file.puts custom_fields}
		else
			output = Array.new
			counter = 0 # This will help us keep track of lines

			File.open(@file).each do |line|
				output << line

				# When we reach a line that includes "function #{@name}_custom_fields"
				# it means that we have to add the items two lines later
				if line.include?("function #{@name}_custom_fields")
					# Negative number, so we know that this + 1 will we the line
					# after which we want to add text
					counter = -2
				end

				# Ok! It's ok to add the new items here, after 'return array('
				if counter === -1 and line.include?('return array(')
					output << fields_php_array
				end

				counter = counter + 1
			end

			File.open(@file, 'w') {|file| file.puts output}
		end

		# Make sure they can be saved
		text = File.read(@file)
		unless text.include? "function #{@name}_meta_box"
			template = File.read("#{Aina::TEMPLATES_DIR}/add.php")
			['{{name}}'].each do |replace|
				attribute = replace.gsub(/[{}]/, '')
				@output = template.gsub!(/#{replace}/, self.send(attribute))
			end
			File.open(@file, "a+") {|file| file.puts @output}
		end
	end

	def self.accepts?(type)
		Generable.accepts?(type)
	end

	protected
		def validate_name(name)
			unless File.exists?(Dir.pwd + "/post-types/#{name}.php")
				raise Exception, "There's no file named /post-types/#{name}.php"
			end
			name
		end
end