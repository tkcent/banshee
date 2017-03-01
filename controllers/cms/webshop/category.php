<?php
	class cms_webshop_category_controller extends Banshee\tablemanager_controller {
		protected $name = "Shop category";
		protected $pathinfo_offset = 3;
		protected $back = "cms";
		protected $icon = "categories.png";
		protected $page_size = 25;
		protected $pagination_links = 7;
		protected $pagination_step = 1;
		protected $foreign_null = "---";
		protected $browsing = "pagination";
	}
?>
