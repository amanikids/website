<?php get_header(); ?>

<div id="left">
  <img src="<?php bloginfo('template_directory'); ?>/images/pic4.jpg" />
</div>

<div id="right">
	<?php if (have_posts()) : while (have_posts()) : the_post(); ?>
	  <div>
      <h1><?php if (!is_single()) : ?><a href="<?php the_permalink() ?>" rel="bookmark"><?php the_title(); ?></a><?php else : ?><?php the_title(); ?><?php endif; ?></h1>
      <?php the_content(); ?>
      <p>Posted by <?php the_author(); ?> on <?php the_time('F d, Y') ?>.</p>
    </div>
  <?php endwhile; endif; ?>
</div>

<?php get_footer(); ?>
