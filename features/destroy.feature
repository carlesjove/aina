Feature: Aina can destroy what she generates.

  Scenario: User destroys a generated post-type
    Given the file "post-types/hello.php" exists
    When I succesfully run "aina destroy post_type hello"
    Then the file "post-types/hello.php" should not exist

  Scenario: User destroys a generated template
    Given the file "template-hello.php" exists
    When I succesfully run "aina destroy template hello"
    Then the file "template-hello.php" should not exist

