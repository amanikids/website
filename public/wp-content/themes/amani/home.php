<?php get_header(); ?>

<div id="left_home">
  <img style="float:left;" src="<?php bloginfo('template_directory'); ?>/images/pic1.jpg" />
  <img style="float:right;" src="<?php bloginfo('template_directory'); ?>/images/pic3.jpg" />
  <img src="<?php bloginfo('template_directory'); ?>/images/pic2.jpg" />
</div>

<div id="right_home">
  <h2>Rescuing Children.</h2>
  <h2>Restoring Hope.</h2>
  <h2>Transforming Lives.</h2>
  
  <p>Amani Children's Home is dedicated to the protection of Tanzania's most vulnerable population: street-children and AIDS orphans.</p>
  <p>Since its founding by local Tanzanians in 2001, Amani Children's Home has rescued over 290 children from the perils of life on the streets, where children face a high risk of HIV transmission and malnutrition.</p>
  <p>We welcome donations from all who want to help us give these precious children a haven from neglect and abuse.</p>
  
	<?php if (have_posts()) : ?>
    <ul>
      <?php while (have_posts()) : the_post(); ?>
        <li><a href="<?php the_permalink() ?>" rel="bookmark"><?php the_title(); ?></a></li>
      <?php endwhile; ?>
    </ul>
  <?php endif; ?>
</div>

<?php get_footer(); ?>
