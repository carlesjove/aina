# Generable class
class Generable
	attr_reader :type, :template, :name, :name_capitalize, :aina_version, :supports

	TEMPLATES_DIR = File.expand_path('../../..',__FILE__) + '/templates'

	GENERABLE_TYPES = { 
		'post_type' => { 
			'template' => 'post_type.php' 
		}
	}

	def initialize(type, name, options=nil)
		@type = type
		@name = name 
		@name_capitalize = name.capitalize
		@aina_version = Aina::VERSION
		@options = options
		@file = Dir.pwd + "/#{@name}.php"
		@template = "#{TEMPLATES_DIR}/#{@type}.php"
	end

	def is_generable?
		GENERABLE_TYPES.include?(@type)
	end

	def supports
		if @options[:s]
			@supports = Array.new
			s = @options[:s].split(',')
			s.each do |item|
				@supports << "'#{item}'"
			end
			@supports.join(',')
		end
	end

	def generate
		text = File.read(@template)
		to_replace = ['{{name}}', '{{name_capitalize}}', '{{aina_version}}', '{{supports}}']
		to_replace.each do |replace|
			attribute = replace.gsub(/[{}]/, '')
			@output = text.gsub!(/#{replace}/, self.send(attribute))
		end
  	File.open(@file, "w") {|file| file.puts @output}
	end

	def destroy
		if File.exists?(@file)
			File.delete(@file)
		else
			raise "No #{@type} with name #{@name}"
		end
	end
end