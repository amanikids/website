<? get_header(); ?>

<div id="container">
  <? if (!is_home()) : ?>
  <div id="sub_nav">
    <? $parent_id = ($post->post_parent) ? $post->post_parent : $post->ID ?>
    <? wp_list_pages('title_li=&child_of='.$parent_id); ?>
  </div>
<? endif ?>

<div id="left">
</div>

<div id="right">
	<? if (have_posts()) : while (have_posts()) : the_post(); ?>
    <? the_content(); ?>
  <? endwhile; endif; ?>
</div>

<? get_footer(); ?>
