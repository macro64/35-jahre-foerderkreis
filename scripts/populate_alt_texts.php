<?php
// Script to auto-populate media alt texts based on filenames
if ( ! defined( 'ABSPATH' ) ) exit;

function populate_media_alt_texts() {
    $args = array(
        'post_type' => 'attachment',
        'posts_per_page' => -1,
    );
    $attachments = get_posts( $args );

    if ( $attachments ) {
        foreach ( $attachments as $attachment ) {
            // Get file name without extension
            $file_name = pathinfo( get_attached_file( $attachment->ID ), PATHINFO_FILENAME );
            // Set alt text
            update_post_meta( $attachment->ID, '_wp_attachment_image_alt', $file_name );
        }
    }
}

// Call the function
populate_media_alt_texts();
