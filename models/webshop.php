<?php
	class webshop_model extends model {
		public function count_articles($search = null) {
			$query = "select count(*) as count from shop_articles where visible=%d";
			$args = array(YES);

			if ($search != null) {
				$query .= " and title like %s";
				array_push($args, "%".$search."%");
			}

			if (($result = $this->db->execute($query, $args)) === false) {
				return false;
			}

			return (int)$result[0]["count"];
		}

		public function get_articles($offset, $limit, $search = null) {
			$query = "select * from shop_articles where visible=%d";
			$args = array(YES);

			if ($search != null) {
				$query .= " and title like %s";
				array_push($args, "%".$search."%");
			}

			$query .= " order by title limit %d,%d";
			array_push($args, $offset, $limit);

			return $this->db->execute($query, $args);
		}

		public function get_article($article_id) {
			$query = "select * from shop_articles where id=%d and visible=%d";
			if (($result = $this->db->execute($query, $article_id, YES)) == false) {
				return false;
			}

			return $result[0];
		}
	}
?>
