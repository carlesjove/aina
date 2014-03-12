# Generable class
class Generable
	attr_reader :type, :template, :name, :name_capitalize, :aina_version, :supports

	TEMPLATES_DIR = File.expand_path('../../..',__FILE__) + '/templates'

	GENERABLE_TYPES = { 
		'post_type' => { 
			'template' => 'post_type.php',
			'dir' => 'post-types' 
		}
	}

	def initialize(type, name, options=nil)
		@type = type
		@name = name 
		@name_capitalize = name.capitalize
		@aina_version = Aina::VERSION
		@options = options
		@file = generate_file_name
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

	private
		def generate_file_name
			unless GENERABLE_TYPES[@type]['dir'].nil?
				unless Dir.exists?(Dir.pwd + '/' + GENERABLE_TYPES[@type]['dir'])
					Dir.mkdir(Dir.pwd + '/' + GENERABLE_TYPES[@type]['dir'])
				end
				Dir.pwd + "/#{GENERABLE_TYPES[@type]['dir']}/#{@name}.php"
			else
				Dir.pwd + "/#{@name}.php"
			end
		end
end