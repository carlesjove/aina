Feature: Aina Framework can be installed 
	People may want to use this shit, so they'll
	have to install it on WordPress
	 
  Scenario: Aina Framework can be installed
  	Given the file "inc/aina.php" doesn't exist
  	When I succesfully run "aina install"
  	Then aina should be installed
