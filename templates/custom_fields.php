<?php
// Custom data fields
add_action("admin_init", "admin_init");
 
// add_meta_box( $id, $title, $callback, $page, $context, $priority );
function admin_init(){
  add_meta_box("info_extra", "Informació extra", "project_meta", "portfolio", "normal", "low");
}
 
function project_meta() {
	global $post;
	$custom 			= get_post_custom($post->ID);
	$info_extra 		= $custom["info_extra"][0];

	?>
	<p><label>Informació extra</label><br />
	<input type="text" name="info_extra" value="<?php echo $info_extra; ?>" style="width: 100%;"/></p>
	<?php
}

// Make sure we can save it
add_action('save_post', 'save_project');

function save_project(){
	global $post;
	update_post_meta($post->ID, "info_extra", $_POST["info_extra"]);
}

function project_has_details($id) {
	$custom_fields = get_post_custom($id);
	$details = array(
		'info_extra',
	);
	
	foreach ($details as $detail) {
		if( ! empty($custom_fields[$detail][0]))
			return true;
	}
	
	return false;
}

function the_extra_info() {
	global $post;
	$custom_fields = get_post_custom($post->ID);
	
	if ( !empty($custom_fields['info_extra'][0]) ) {
		echo "<span class=\"title-extra\">/ {$custom_fields['info_extra'][0]} </span>";
	}
	return false;
}