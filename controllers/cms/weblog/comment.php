<?php
	class cms_weblog_comment_controller extends Banshee\tablemanager_controller {
		protected $name = "Weblog comment";
		protected $pathinfo_offset = 3;
		protected $back = "cms/weblog";
		protected $icon = "forum.png";
		protected $page_size = 25;
		protected $pagination_links = 7;
		protected $pagination_step = 1;
		protected $foreign_null = "---";
		protected $browsing = "pagination";
	}
?>
