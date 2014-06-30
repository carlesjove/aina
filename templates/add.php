/**
 * Add meta box
 * add_meta_box( $id, $title, $callback, $post_type, $context, $priority );
 */
if ( ! function_exists('{{name}}_meta_box') ) {
	function {{name}}_meta_box(){
	  add_meta_box("{{name}}_meta", "Extra", "add_{{name}}_custom_fields", "{{name}}", "normal", "low");
	}
	add_action("admin_init", "{{name}}_meta_box");
}

/**
 * Add Custom Fields
 */
if ( ! function_exists('add_{{name}}_custom_fields') ) {
	function add_{{name}}_custom_fields() {
	    aina_add_custom_fields('{{name}}');
	}
}

/**
 * Make sure we can save it
 */
if ( ! function_exists('save_{{name}}_custom') ) {
	function save_{{name}}_custom() {
	  aina_save_custom('{{name}}');
	}
	add_action('save_post', 'save_{{name}}_custom');
}