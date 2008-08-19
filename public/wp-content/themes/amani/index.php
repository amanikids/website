<? get_header(); ?>

<div id="left">
  <img src="<? bloginfo('template_directory'); ?>/images/pic4.jpg" />
</div>

<div id="right">
	<? if (have_posts()) : while (have_posts()) : the_post(); ?>
	  <div>
  	  <h1><? if (!is_single()) : ?><a href="<? the_permalink() ?>" rel="bookmark"><? the_title(); ?></a><? else : ?><? the_title(); ?><? endif; ?></h1>
      <? the_content(); ?>
      <p>Posted by <? the_author(); ?> on <? the_time('F d, Y') ?>.</p>
    </div>
  <? endwhile; endif; ?>
</div>

<? get_footer(); ?>
