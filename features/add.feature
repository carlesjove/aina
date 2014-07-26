Feature: Aina can add extra code to existing models (post-types) previously generated.

	Scenario: Adding meta fields to a post-type works
		Given the file "post-types/hello.php" doesn't exist
		When I succesfully run "aina generate post_type hello"
		And I succesfully run "aina add hello name:text email:email"
		Then a file named "post-types/hello.php" should exist
		And the file "post-types/hello.php" should contain "function hello_custom_fields"
		And the file "post-types/hello.php" should contain "'name' => array("
		And the file "post-types/hello.php" should contain "'email' => array("

	Scenario: Meta fields without type won't be added
			Given the file "post-types/test.php" doesn't exist
			When I succesfully run "aina generate post_type test"
			And I succesfully run "aina add test name email"
			Then a file named "post-types/test.php" should exist
			And the file "post-types/test.php" should not contain "function test_custom_fields"
			And the output should contain "Type was missing"
