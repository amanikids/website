<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title><?php bloginfo('name'); ?> <?php wp_title(); ?></title>
  <link href="<? bloginfo('stylesheet_url'); ?>" type="text/css" rel="stylesheet">
  <link rel="alternate" type="application/atom+xml" title="Atom 1.0" href="<? bloginfo('atom_url'); ?>" />
</head>

<body>
  <div id="container">
    <div id="logo">
      <a href="<? bloginfo('home'); ?>"><img border="none" src="<? bloginfo('template_directory'); ?>/images/logo.jpg" /></a>
    </div>
    
    <div id="upper_nav">
      <ul>
        <li><a href="<? bloginfo('home'); ?>"><img border="none" src="<? bloginfo('template_directory'); ?>/images/home.jpg" /><br />HOME / </a></li>
        <li><a href="/donate"><img border="none" src="<? bloginfo('template_directory'); ?>/images/donate.jpg" /><br />DONATE / </a></li>
        <li><a href="mailto:joe@amanikids.org?subject=Sign%20me%20up!"><img border="none" src="<? bloginfo('template_directory'); ?>/images/subscribe.jpg" /><br />SUBSCRIBE</a></li>
      </ul>
    </div>

    <? if (!is_home()) : ?>
      <div id="tag_line">
        <h2>Rescuing Children.</h2>
        <h2>Restoring Hope.</h2>
        <h2>Transforming Lives.</h2>
      </div>
    <? endif; ?>
  </div>
  
  <div id="main_nav">
    <div id="container">
      <ul>
        <? wp_list_pages('depth=1&title_li=How+Amani+Helps+Tanzanian+Kids&meta_key=section&meta_value=how-amani-helps'); ?>
        <? wp_list_pages('depth=1&title_li=How+You+Can+Help&meta_key=section&meta_value=how-you-can-help'); ?>
        <? wp_list_pages('depth=1&title_li=Meet+Our+Kids&meta_key=section&meta_value=meet-our-kids'); ?>
        <? wp_list_pages('depth=1&title_li=Mission,+History,+and+Supporters&meta_key=section&meta_value=mission-history-supporters'); ?>
      </ul>
    </div>    
  </div>

  <div id="container">
