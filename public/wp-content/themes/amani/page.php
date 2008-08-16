<? get_header(); ?>

<div id="sub_nav">
  <? $parent_id = ($post->post_parent) ? $post->post_parent : $post->ID ?>
  <? wp_list_pages('title_li=&child_of='.$parent_id); ?>
</div>

<div id="left">
  <img src="<? bloginfo('template_directory'); ?>/images/pic4.jpg" />
</div>

<div id="right">
	<? if (have_posts()) : while (have_posts()) : the_post(); ?>
	  <h1><? the_title(); ?></h1>
    <? the_content(); ?>
  <? endwhile; endif; ?>
</div>

<? get_footer(); ?>
