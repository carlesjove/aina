Feature: Aina can generate a bunch of WordPress code.
  Let's test it.

  Scenario: Custom Post-Types can be generated
    Given the file "post-types/hello.php" doesn't exist
    When I succesfully run "aina generate post_type hello"
    Then a file named "post-types/hello.php" should exist
    And the file named "post-types/hello.php" should contain "Custom Post Type: Hello"

  Scenario: Post types with multiple words can be generated
    Given the file "post-types/my_post_type.php" doesn't exist
    When I succesfully run "aina g post_type my_post_type"
    Then a file named "post-types/my_post_type.php" should exist
    And the file "post-types/my_post_type.php" should contain "Add New My Post Type Item"

  Scenario: Post types can be generated using a string
    Given the file "post-types/my_post_type.php" doesn't exist
    When I succesfully run "aina g post_type 'my post type'"
    Then a file named "post-types/my_post_type.php" should exist
    And the file "post-types/my_post_type.php" should contain "Add New My Post Type Item"

  Scenario: Generating a post-type won't overwrite it if already exists
    Given the file "post-types/hello.php" exists
    When I succesfully run "aina generate post_type hello"
    Then the output should contain "already exists"

  Scenario: When generating a post_type, meta fields will also be added, if passed
    Given the file "post-types/hello.php" doesn't exist
    When I succesfully run "aina generate post_type hello name:text email:email"
    Then a file named "post-types/hello.php" should exist
    And the file "post-types/hello.php" should contain "function hello_custom_fields"
    And the file "post-types/hello.php" should contain "'name' => array("
    And the file "post-types/hello.php" should contain "'email' => array("

  Scenario: When generating a post_type, meta fields won't be added if passed incorrectly
    Given the file "post-types/hello.php" doesn't exist
    When I succesfully run "aina generate post_type hello name email"
    Then a file named "post-types/hello.php" should exist
    And the file "post-types/hello.php" should not contain "function hello_custom_fields"
    And the output should contain "Type was missing"

  Scenario: When generating a post_type, meta fields won't be added if invalid
    Given the file "post-types/hello.php" doesn't exist
    When I succesfully run "aina generate post_type hello name:fuck email:damm"
    Then a file named "post-types/hello.php" should exist
    And the file "post-types/hello.php" should not contain "function hello_custom_fields"
    And the output should contain "not a valid type"

  Scenario: Page templates can be generated
    Given the file "template-hello_world.php" doesn't exist
    When I succesfully run "aina generate template hello_world"
    Then a file named "template-hello_world.php" should exist
    And the file "template-hello_world.php" should contain "Template Name: Hello World"

