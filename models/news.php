<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class news_model extends Banshee\model {
		public function count_news() {
			$query = "select count(*) as count from news";

			if (($result = $this->db->execute($query)) === false) {
				return false;
			}

			return $result[0]["count"];
		}

		public function get_news($offset, $limit) {
			$query = "select *, UNIX_TIMESTAMP(timestamp) as timestamp from news ".
					 "where timestamp<now() order by timestamp desc limit %d,%d";

			return $this->db->execute($query, $offset, $limit);
		}

		public function get_news_item($id) {
			$query = "select * from news where id=%d";

			if ($this->user->access_allowed("cms/news") == false) {
				$query .= " and timestamp<now()";
			}

			if (($result = $this->db->execute($query, $id)) === false) {
				return false;
			}

			return $result[0];
		}
	}
?>
