Aina
=====

**THIS PROJECT IS NO LONGER MANTAINED.**
**Feel free to continue it yourself if you wish. I'm open to provide access to
Rubygems for new releases.**

Code generation for WordPress *themes*, from the Command Line.

**Please, notice that the current version of Aina is 0.x, which means that it's in an early stage of development. Use it at your own risk. No backward compatibility issues will be considered until version 1.x**.

## Overview
As of the current version, Aina allows you to generate WordPress custom post types and add custom meta fields to them, from the command line. Aina is mainly conceived as a CLI, but after you have it running in your theme, you can also add custom fields manually in your post types' files taking advantage of Aina's framework.

## Installation
Since Aina is a Ruby gem, you must have a Ruby environment running in your machine. You can install Aina from RubyGems:

`gem install aina`

## Usage
Aina runs within themes, so the first step is moving to your theme directory. *Aina will throw an error if you're not in a theme*.

`$ cd path/to/my/wordpress/theme`

This is the list of Aina's current commands.

### Generate
The `generate` command (or `g` in its abbreviated form) lets you generate
WordPress elements. It also includes them in your `functions.php` so you don't
need to do it manually. You can create Post Types and page templates.

`$ aina generate <element_type> <element_name>`

This is how you would create a new custom post type named Project:

```
$ aina generate post_type project

# This will create a post type named Project in /post-types/project.php
```

This is how you would create a Page Template named Hello World:

```bash
$ aina g template hello_world

# Will generate a page template at /template-hello_world.php
```

### Add
The `add` command lets you add custom meta fields to post types:

`$ aina add <element_name> <field:type>`

**Options:** Field types are regular HTML `input` types. Current available options are:

- text
- url
- email
- datetime, datetime-local
- textarea
- radio
- checkbox
- select

Taking the previous example, let's add four custom fields to the Project post type:

`$ aina add project client:text year:date website:text kind:select`

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

Of course, if you feel like adding more custom fields to the Project post type, you can do it again, and they will be *preppended* to the existing ones.

**Tip:** It is possible to generate an element and add to it with a single command. If we wanted to generate a Project post-type and add some meta fields to it, we would run:

`$ aina generate post_type project name:text website:url`

## Why Aina, and why a Ruby gem?

I was a WP developer. I wanted to learn Ruby. I started by writing a tool that
generated WP code.

PS: Aina is my first daughter's name :heart:

