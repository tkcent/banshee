<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class banshee_page_model extends Banshee\model {
		public function get_page($url) {
			return $this->db->entry("pages", $url, "url");
		}
	}
?>
