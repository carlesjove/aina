class PostType < Generable::Base
	attr_reader :name_capitalize, :capability, :supports

	DEFAULT_SUPPORT 	 = 'title,editor,excerpt,thumbnail'
	DEFAULT_CAPABILITY = 'post'

	template 'post_type.php'
	dir 'post-types'
	replacements %w(name_capitalize capability supports)

	after_generate :install_aina_framework?

	def set_custom_vars
		@name_capitalize = self.name.capitalize
		if @options
			@supports = get_supports
			@capability = get_capability
		end
	end

	def get_supports
		s = @options[:s] ? @options[:s] : DEFAULT_SUPPORT
		s = s.split(',')

		supports = Array.new
		s.each do |item|
			supports << "'#{item}'"
		end
		supports.join(',')
	end

	def get_capability
		@options[:c] ? @options[:c] : DEFAULT_CAPABILITY
	end

	protected
		def install_aina_framework?
			if @options and @options[:i]
				Aina.install
			end
		end

		# TODO
		# Include post_type automatically in functions.php
		# def include
		# 	output = "/**\n"
		# 	output += " * Include Post-Types for Aina\n"
		# 	output += " */\n"
		# 	output += "function aina_post_types() {\n"
  # 		output += "	$post_types = array();\n"
  # 		output += "	$post_types[] = '#{@name}';\n"
  # 		output += "	return $post_types;\n"
  # 		output += "}\n\n"
		# end
end