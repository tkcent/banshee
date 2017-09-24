<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class cms_photos_album_controller extends Banshee\tablemanager_controller {
		protected $name = "Photo album";
		protected $back = "cms";
		protected $icon = "album.png";
		protected $page_size = 25;
		protected $pagination_links = 7;
		protected $pagination_step = 1;
		protected $foreign_null = "---";

		public function show_overview() {
			$this->view->add_javascript("cms/photos/album.js");
			parent::show_overview();
		}
	}
?>
