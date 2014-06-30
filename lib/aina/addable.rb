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
			@fields << {key: a[0], type: a[1]}
		end
	end

	def fields_php_array
		a = ''
		@fields.each do |f|
			a += "'#{f[:key]}' => array(\n"
	    a += "  'label'     => '#{f[:key].capitalize}',\n"
      a += "  'type'      => '#{f[:type]}',\n"
      a += "  'options' 	=> array('option_1', 'option_2', 'etc'),\n" if %w(radio checkbox select).include?(f[:type])
      a += "),\n" 
		end
		a
	end

	def custom_fields
		# TODO: Check if function already exists,
		# and if it does, only add to the array
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
		
		# Add Custom Fields
		File.open(@file, 'a+') {|file| file.puts custom_fields}

		# Make sure they can be saved
		# TODO: Check if this template code already exists in the post type,
		# so we don't pollute with useless code
		text = File.read("#{Aina::TEMPLATES_DIR}/add.php")
		['{{name}}'].each do |replace|
			attribute = replace.gsub(/[{}]/, '')
			@output = text.gsub!(/#{replace}/, self.send(attribute))
		end
  	File.open(@file, "a+") {|file| file.puts @output}
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