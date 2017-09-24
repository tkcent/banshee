<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class links_model extends Banshee\model {
		public function get_links() {
			$query = "select l.*,c.category from links l left join link_categories c ".
			         "on c.id=l.category_id order by category, text";

			if (($links = $this->db->execute($query)) === false) {
				return false;
			}

			$result = array();
			foreach ($links as $link) {
				if (in_array($link["category"], array_keys($result)) == false) {
					$result[$link["category"]] = array();
				}
				array_push($result[$link["category"]], $link);
			}

			return $result;
		}
	}
?>
