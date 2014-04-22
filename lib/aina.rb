# Lib
Dir.glob(File.dirname(__FILE__) + "/aina/*.rb") { |file|  require file }
Dir.glob(File.dirname(__FILE__) + "/aina/generable/*.rb") { |file|  require file }
Dir.glob(File.dirname(__FILE__) + "/aina/generable/types/*.rb") { |file|  require file }

# Templates
Dir.glob(File.expand_path('..') + "/templates/*") { |file|  require file }
