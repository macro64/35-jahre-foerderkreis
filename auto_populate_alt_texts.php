<?php
// Script to update alt texts for images in the media library
// Define the media items with empty alt texts
$media_items = [
    ['id' => 12, 'filename' => 'cropped-Logo_220x280.png', 'generated_alt' => 'Cropped Logo 220x280'],
    ['id' => 11, 'filename' => 'Logo_220x280.png', 'generated_alt' => 'Logo 220x280'],
    ['id' => 9, 'filename' => 'Glasmuseum_Lauscha_vitrinen.jpg', 'generated_alt' => 'Glasmuseum Lauscha Vitrinen'],
    ['id' => 1053, 'filename' => 'Hubert-Koch.jpg', 'generated_alt' => 'Portrait of Hubert Koch'],
    ['id' => 1027, 'filename' => 'Hartmut-Bechmann-.jpg', 'generated_alt' => 'Portrait of Hartmut Bechmann']
];

foreach ($media_items as $item) {
    // Assuming a function update_media_alt_text exists to update the alt text in WordPress
    update_media_alt_text($item['id'], $item['generated_alt']);
}

function update_media_alt_text($id, $alt_text) {
    // Similar to `wp_update_attachment_metadata` function in WP to update the alt text of an image
    // Retrieve the image attachment
    $attachment = wp_get_attachment_metadata($id);
    if ($attachment) {
        // Update the alt text
        update_post_meta($id, '_wp_attachment_image_alt', $alt_text);
        echo "Updated alt text for image ID: $id to '$alt_text'.\n";
    } else {
        echo "Failed to find image ID: $id.\n";
    }
}
?>