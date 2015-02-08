module Generable
  # List of generable types
  def self.generable_types
    g = Array.new
    Dir.glob(File.dirname(__FILE__) + "/generable/types/*.rb").each do |f|
      g << f.split('/').last.split('.rb').join()
    end
    g
  end

  def self.class_name_for(type)
    "Generable::#{type.camelcase}"
  end

  # Is generable?
  def self.accepts?(type)
    generable_types.include?(type)
  end

  # Does type need to be created in a directory?
  # Then, in type use: 
  # dir 'my-directory'
  def dir(directory)
    @dir = directory
  end

  def get_dir
    @dir
  end

  # Does type use a template?
  # Then, in type use: 
  # template 'my-template.php'
  def template(template)
    @template = "#{Aina::TEMPLATES_DIR}/#{template}" if template
  end

  def get_template
    @template
  end

  # Does type template need custom replacements?
  # Then, in type use: 
  # replacements %w({{replace_this}} {{and_this_too}})
  def replacements(*replacements)
    @replacements = %w(name aina_version)
    @replacements += replacements.flatten if replacements
    @replacements = @replacements.map { |r| "{{#{r}}}" }
  end

  def get_replacements
    @replacements || []
  end

  def after_generate(*callbacks)
    @after_generate = callbacks
  end

  def get_after_generate
    @after_generate
  end
end
