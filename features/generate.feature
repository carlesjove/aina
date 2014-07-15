Feature: Aina can generate a bunch of WordPress code.
	Let's test it.

	Scenario: Custom Post-Types can be generated
		Given the file "post-types/hello.php" doesn't exist
		When I succesfully run "aina generate post_type hello"
		Then a file named "post-types/hello.php" should exist

	Scenario: Generating a post-type won't overwrite it if already exists
		Given the file "post-types/hello.php" exists
		When I succesfully run "aina generate post_type hello"
		Then the output should contain "already exists"