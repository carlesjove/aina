class Template < Generable::Base
  template "page_template.php"
  replacements %w(display_name)

  def name
    "template-#{@original_name}"
  end

  def display_name
    @original_name.
      split("_").
      map { |w| w.capitalize! }.
      join(" ")
  end
end

