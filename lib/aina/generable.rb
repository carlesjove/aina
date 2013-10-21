# Generable class
class Generable
	attr_reader :type, :template, :name, :name_capitalize, :aina_version

	TEMPLATES_DIR = 'templates'

	GENERABLE_TYPES = { 
		'post-type' => { 
			'template' => 'post-type.php' 
		}
	}

	def initialize(type, name)
		@type = type
		@name = name 
		@name_capitalize = name.capitalize
		@aina_version = Aina::VERSION
		@template = "#{TEMPLATES_DIR}/#{@type}.php"
	end

	def is_generable?
		GENERABLE_TYPES.include?(@type)
	end

	def generate
		text = File.read(@template)
		to_replace = ['{{name}}', '{{name_capitalize}}', '{{aina_version}}']
		to_replace.each do |replace|
			attribute = replace.gsub(/[{}]/, '')
			@output = text.gsub!(/#{replace}/, self.send(attribute))
		end
  	File.open("../#{@name}.php", "w") {|file| file.puts @output}
	end
end