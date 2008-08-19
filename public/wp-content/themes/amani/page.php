<?php get_header(); ?>

<div id="sub_nav">
  <?php $parent_id = ($post->post_parent) ? $post->post_parent : $post->ID ?>
  <?php wp_list_pages('title_li=&child_of='.$parent_id); ?>
</div>

<div id="left">
  <img src="<?php bloginfo('template_directory'); ?>/images/pic4.jpg" />
</div>

<div id="right">
	<?php if (have_posts()) : while (have_posts()) : the_post(); ?>
	  <h1><?php the_title(); ?></h1>
    <?php the_content(); ?>
  <?php endwhile; endif; ?>
</div>

<?php get_footer(); ?>
