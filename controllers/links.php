<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class links_controller extends Banshee\controller {
		public function execute() {
			$this->view->title = "Links";
			$this->view->keywords = "links";
			$this->view->description = "Links naar websites over privacy";

			if (($data = $this->model->get_links()) === false) {
				$this->view->add_tag("result", "Database error.");
			} else foreach ($data as $category => $links) {
				$this->view->open_tag("links", array("category" => $category));
				foreach ($links as $link) {
					$this->view->add_tag("link", $link["text"], array("url" => $link["link"]));
				}
				$this->view->close_tag();
			}
		}
	}
?>
