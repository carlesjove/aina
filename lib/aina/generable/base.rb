# Generable class
class Generable::Base
  extend Generable
  attr_reader :name, :template, :file, :aina_version, :supports

  def initialize(name, options=nil)
    @name = name
    @options = options
    @aina_version = Aina::VERSION
    @template = self.template
    @dir = self.dir
    @file = generate_file_name

    set_custom_vars
  end

  def set_custom_vars
    # Nothing here
    # This can be used in types to parse required instance variables
  end

  def dir
    self.class.get_dir
  end

  def template
    self.class.get_template
  end

  def replacements
    self.class.get_replacements
  end

  def generate
    text = File.read(@template)
    replacements.each do |replace|
      attribute = replace.gsub(/[{}]/, '')
      @output = text.gsub!(/#{replace}/, self.send(attribute))
    end
    File.open(@file, "w") {|file| file.puts @output}

    after_generate
  end

  def after_generate
    if self.class.get_after_generate
      self.class.get_after_generate.each do |callback|
        self.send(callback)
      end
    end
  end

  def destroy
    if File.exists?(@file)
      File.delete(@file)
    else
      raise "No #{self.class} with name #{@name}"
    end
  end

  private
    def generate_file_name
      unless @dir.nil?
        unless Dir.exists?(Dir.pwd + '/' + @dir)
          Dir.mkdir(Dir.pwd + '/' + @dir)
        end
        Dir.pwd + "/#{@dir}/#{@name}.php"
      else
        Dir.pwd + "/#{@name}.php"
      end
    end
end
