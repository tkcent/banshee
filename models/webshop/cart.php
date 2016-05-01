<?php
	class webshop_cart_model extends model {
		public function get_articles($article_ids) {
			if (is_array($article_ids) == false) {
				return array();
			} else if (count($article_ids) == 0) {
				return array();
			}

			$query = "select * from shop_articles where id in (".
				implode(", ", array_fill(0, count($article_ids), "%d")).
				") order by title";

			return $this->db->execute($query, $article_ids);
		}

		public function get_article($article_id) {
			return $this->borrow("webshop")->get_article($article_id);
		}
	}
?>
