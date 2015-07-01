<?php
	class cms_album_controller extends tablemanager_controller {
		protected $name = "Photo album";
		protected $pathinfo_offset = 2;
		protected $back = "cms";
		protected $icon = "album.png";
		protected $page_size = 25;
		protected $pagination_links = 7;
		protected $pagination_step = 1;
		protected $foreign_null = "---";
	}
?>
