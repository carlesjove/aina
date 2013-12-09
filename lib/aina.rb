# Lib
Dir.glob(File.dirname(__FILE__) + "/aina/*") { |file|  require file }

# Templates
Dir.glob(File.expand_path('..') + "/templates/*") { |file|  require file }
