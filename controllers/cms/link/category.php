<?php
	class cms_link_category_controller extends Banshee\tablemanager_controller {
		protected $name = "Category";
		protected $pathinfo_offset = 3;
		protected $back = "cms/link";
		protected $icon = "links.png";
		protected $page_size = 25;
		protected $browsing = null;
	}
?>
