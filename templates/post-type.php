<?php

/**
 * Custom Post Type: {{name}}
 * Generated with Aina. Version {{aina_version}}
 */

/* {{name_capitalize}} Properties */
function {{name}}_register() {
    $labels = array(
        'name'                  => _x("{{name_capitalize}}", {{name}}),
        'singular_name'         => _x("{{name_capitalize}} Item", {{name}}),
        'add_new'               => _x('New {{name_capitalize}} Item', {{name}}),
        'add_new_item'          => __('Add New {{name_capitalize}} Item'),
        'edit_item'             => __('Edit {{name_capitalize}} Item'),
        'new_item'              => __('New {{name_capitalize}} Item'),
        'view_item'             => __('View {{name_capitalize}} Item'),
        'search_items'          => __('Search {{name_capitalize}} Items'),
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
    register_post_type( {{name}} , $args );
}

add_action('init', '{{name}}_register');


/* {{name_capitalize}} Taxonomy */
add_action( 'init', 'register_taxonomy_{{name}}categories' );

function register_taxonomy_{{name}}categories() {
    // Taxonomy slug
    ${{name}}_taxonomy = '{{name}}categories';

    $labels = array( 
        'name'                       => _x( '{{name_capitalize}} Categories', ${{name}}_taxonomy ),
        'singular_name'              => _x( '{{name_capitalize}} Category', ${{name}}_taxonomy ),
        'search_items'               => _x( 'Search {{name_capitalize}} Category', ${{name}}_taxonomy ),
        'popular_items'              => _x( 'Popular {{name_capitalize}} Category', ${{name}}_taxonomy ),
        'all_items'                  => _x( 'All {{name_capitalize}} Category', ${{name}}_taxonomy ),
        'parent_item'                => _x( 'Parent {{name_capitalize}} Category', ${{name}}_taxonomy ),
        'parent_item_colon'          => _x( 'Parent {{name_capitalize}} Category:', ${{name}}_taxonomy ),
        'edit_item'                  => _x( 'Edit {{name_capitalize}} Category', ${{name}}_taxonomy ),
        'update_item'                => _x( 'Update {{name_capitalize}} Category', ${{name}}_taxonomy ),
        'add_new_item'               => _x( 'Add New {{name_capitalize}} Category', ${{name}}_taxonomy ),
        'new_item_name'              => _x( 'New {{name_capitalize}} Category', ${{name}}_taxonomy ),
        'separate_items_with_commas' => _x( 'Separate {{name_capitalize}} Categories with commas', ${{name}}_taxonomy ),
        'add_or_remove_items'        => _x( 'Add or remove {{name_capitalize}} Categories', ${{name}}_taxonomy ),
        'choose_from_most_used'      => _x( 'Choose from the most used {{name_capitalize}} Categories', ${{name}}_taxonomy ),
        'menu_name'                  => _x( '{{name_capitalize}} Category', ${{name}}_taxonomy ),
    );

    $args = array( 
        'labels'                => $labels,
        'public'                => true,
        'show_in_nav_menus'     => true,
        'show_ui'               => true,
        'show_tagcloud'         => true,
        'show_admin_column'     => true,
        'hierarchical'          => true,
        //'update_count_callback' => '',
        'rewrite'               => array( 'hierarchical' => true ), // Use taxonomy as categories
        'query_var'             => true
    );

    register_taxonomy( ${{name}}_taxonomy, array({{name}}), $args );
}

/**
 * Displays the {{name_capitalize}} post type icon in the dashboard
 */
add_action( 'admin_head', '{{name}}_icon' );
function {{name}}_icon() {
    echo '<style type="text/css" media="screen">
            #menu-posts-projecte .wp-menu-image {
                background: url(<?php echo get_stylesheet_directory_uri(); ?>/img/{{name}}-icon.png) no-repeat 6px 6px !important;
            }
            #menu-posts-projecte:hover .wp-menu-image, #menu-posts-projecte.wp-has-current-submenu .wp-menu-image {
                background-position:6px -16px !important;
            }
            #icon-edit.icon32-posts-projecte {
                background: url(<?php echo get_stylesheet_directory_uri(); ?>/img/{{name}}-32x32.png) no-repeat;
            }
        </style>';
}

