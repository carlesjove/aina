<?php

/**
 * Custom Post Type: {{name}}
 * Generated with Aina. Version 0.1
 */

$domain_name = '{{name}}';
$name = ucfirst($domain_name);

/* Portfolio Properties */
function portfolio_register() {
    $labels = array(
        'name'                  => _x("{$name}", $domain_name),
        'singular_name'         => _x("{$name} Item", $domain_name),
        'add_new'               => _x('New Portfolio Item', $domain_name),
        'add_new_item'          => __('Add New Portfolio Item'),
        'edit_item'             => __('Edit Portfolio Item'),
        'new_item'              => __('New Portfolio Item'),
        'view_item'             => __('View Portfolio Item'),
        'search_items'          => __('Search Portfolio Items'),
        'not_found'             => __('Nothing found'),
        'not_found_in_trash'    => __('Nothing found in Trash'),
        'parent_item_colon'     => '',
    );
    $args = array(
        'labels'                => $labels,
        'public'                => true,
        'publicly_queryable'    => true,
        'show_ui'               => true,
        'query_var'             => true,
        'menu_icon'             => false, // get_stylesheet_directory_uri() . '/your_pt_icon_here.png'
        'rewrite'               => true,
        'capability_type'       => 'post',
        'hierarchical'          => true,
        'has_archive'           => true,
        'menu_position'         => null,
        'supports'              => array('title','editor','thumbnail','excerpt'),
      ); 
    register_post_type( $domain_name , $args );
}

add_action('init', 'portfolio_register');


/* Portfolio Taxonomy */
add_action( 'init', 'register_taxonomy_portfoliocategories' );

function register_taxonomy_portfoliocategories() {
    // Taxonomy slug
    $portfolio_taxonomy = 'portfoliocategories';

    $labels = array( 
        'name'                       => _x( 'Portfolio Categories', $portfolio_taxonomy ),
        'singular_name'              => _x( 'Portfolio Category', $portfolio_taxonomy ),
        'search_items'               => _x( 'Search Portfolio Category', $portfolio_taxonomy ),
        'popular_items'              => _x( 'Popular Portfolio Category', $portfolio_taxonomy ),
        'all_items'                  => _x( 'All Portfolio Category', $portfolio_taxonomy ),
        'parent_item'                => _x( 'Parent Portfolio Category', $portfolio_taxonomy ),
        'parent_item_colon'          => _x( 'Parent Portfolio Category:', $portfolio_taxonomy ),
        'edit_item'                  => _x( 'Edit Portfolio Category', $portfolio_taxonomy ),
        'update_item'                => _x( 'Update Portfolio Category', $portfolio_taxonomy ),
        'add_new_item'               => _x( 'Add New Portfolio Category', $portfolio_taxonomy ),
        'new_item_name'              => _x( 'New Portfolio Category', $portfolio_taxonomy ),
        'separate_items_with_commas' => _x( 'Separate Portfolio Categories with commas', $portfolio_taxonomy ),
        'add_or_remove_items'        => _x( 'Add or remove Portfolio Categories', $portfolio_taxonomy ),
        'choose_from_most_used'      => _x( 'Choose from the most used Portfolio Categories', $portfolio_taxonomy ),
        'menu_name'                  => _x( 'Portfolio Category', $portfolio_taxonomy ),
    );

    $args = array( 
        'labels'                => $labels,
        'public'                => true,
        'show_in_nav_menus'     => true,
        'show_ui'               => true,
        'show_tagcloud'         => true,
        'show_admin_column'     => true,
        'hierarchical'          => true,
        //'update_count_callback' => 'get_clients_count',
        'rewrite'               => array( 'hierarchical' => true ), // Use taxonomy as categories
        'query_var'             => true
    );

    register_taxonomy( $portfolio_taxonomy, array($domain_name), $args );
}

// Custom data fields
add_action("admin_init", "admin_init");
 
// add_meta_box( $id, $title, $callback, $page, $context, $priority );
function admin_init(){
  add_meta_box("info_extra", "Informació extra", "project_meta", "portfolio", "normal", "low");
}
 
function project_meta() {
    global $post;
    $custom             = get_post_custom($post->ID);
    $info_extra         = $custom["info_extra"][0];

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



/**
 * Displays the Portfolio post type icon in the dashboard
 */
add_action( 'admin_head', 'portfolio_icon' );
function portfolio_icon() { ?>
    <style type="text/css" media="screen">
        #menu-posts-projecte .wp-menu-image {
            background: url(<?php echo get_stylesheet_directory_uri(); ?>/img/portfolio-icon.png) no-repeat 6px 6px !important;
        }
        #menu-posts-projecte:hover .wp-menu-image, #menu-posts-projecte.wp-has-current-submenu .wp-menu-image {
            background-position:6px -16px !important;
        }
        #icon-edit.icon32-posts-projecte {background: url(<?php echo get_stylesheet_directory_uri(); ?>/img/portfolio-32x32.png) no-repeat;}
    </style>
<?php }


