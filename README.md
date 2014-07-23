Aina
=====

Code generation for WordPress *themes*, from the Command Line.

**Please, notice that the current version of Aina is 0.x, which means that it's in an early stage of development. Use it at your own risk. No backward compatibility issues will be considered until version 1.x**.

## Overview
As of the current version, Aina allows you to generate WordPress custom post types and add custom meta fields to them, from the command line. Aina is mainly conceived as a CLI, but after you have it running in your theme, you can also add custom fields manually in your post types' files taking advantage of Aina's framework.

## Usage
This is the list of Aina's current commands.

### Generate
The `generate` command (or `g` in its abbreviated form) lets you generate WordPress elements:

`aina generate <element_type> <element_name>`

Since right now the only available option is `post_type`, this is how you would create a new custom post type named Project:

```
aina generate post_type project

# This will create a post type named Project in /post-types/project.php
```

### Add
The `add` command lets you add custom meta fields to post types:

`aina add <element_name> <field:type>`

**Options:** Field types are regular HTML types. Current options are:

- text
- url
- email
- datetime, datetime-local
- textarea
- radio
- checkbox
- select

Taking the previous example, let's add four custom fields to the Project post type:

`aina add project client:text year:date website:text kind:select`

This will add a function named after your post type (`project_custom_fields()` in the example), that returns an `array` of custom fields, as such:

```
// ...
'name' => array(
  'label'     => 'Name',
  'type'      => 'text',
),
// ...
'kind' => array(
  'label'     => 'Kind',
  'type'      => 'select',
  'options'		=> array('option_1', 'option_2', 'etc'),
),
```

Since `kind` is of type `select`, Aina has added an array of options. You can write your own:

```
'options' 	=> array(
	'one' 		=> 'My first option',
	'two' 		=> 'My second option',
	'three' 	=> 'My third option',
	),
```

## Why?
I know for some it may sound grossy to create a Ruby Gem that generates WordPress code. In my day to day I work a lot with WordPress (85% of my professional time), so having tools that allow me to work faster was a real need. Also, I love Ruby and since I don't get to work on many Ruby projects professionally, I decided to write this tool in Ruby. I know some people will consider it crazyness, but after all it's your choice to use it or not. 