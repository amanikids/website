<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">

<html>
  <head>
    <title>Amani Children's Home</title>
  </head>
  
  <body>
    <h1>Amani Children's Home</h1>
    
    <ul style="float:left">
      <?php
        foreach (flickr_photoset('72157605972458807') as $photo) {
          echo '<li>' . flickr_image_tag_square($photo) . '</li>';
        }
      ?>
    </ul>
    
    <div>
      <?php
        $photo = flickr_photo('2636271200');
        echo flickr_image_tag($photo, 'Medium');
        echo '<p>' . $photo['description'] . '</p>';
      ?>
    </div>
  </body>
</html>