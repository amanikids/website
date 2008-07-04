<?php

ini_set('include_path', ini_get('include_path') . $path_delimiter . dirname(__FILE__) . '/vendor/phpFlickr-2.2.0');

require_once('phpFlickr.php');

function flickr() {
  return new phpFlickr('16c198c4321b70e881846fd03e48d0a3');  
}

function flickr_photoset($id) {
  $set = flickr()->photosets_getPhotos($id);
  return array_reverse($set['photo']);
}

function flickr_image_tag($photo, $size) {
  $sizes = group_by('label', flickr()->photos_getSizes($photo['id']));
  $image = $sizes[$size];
  return '<img src="' . $image['source'] . '" width="' . $image['width'] . '" height="' . $image['height'] . '" />';
}

function flickr_image_tag_square($photo) {
  $src = 'http://farm' . $photo['farm'] . '.static.flickr.com/' . $photo['server'] . '/' . $photo['id'] . '_' . $photo['secret'] . '_s.jpg';
  return '<img src="' . $src . '" width="75" height="75" />';
}

function flickr_photo($id) {
  return flickr()->photos_getInfo($id);
}

function group_by($key, $items) {
  $result = array();
  foreach ($items as $item) {
    $result[$item[$key]] = $item;
  }
  return $result;
}

?>