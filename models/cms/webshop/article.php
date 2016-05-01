<?php
	class cms_webshop_article_model extends model {
		private $columns = array("article_nr", "title", "short_description", "long_description", "price");

		public function count_articles() {
			$query = "select count(*) as count from shop_articles";

			if (($result = $this->db->execute($query)) == false) {
				return false;
			}

			return $result[0]["count"];
		}

		public function get_articles($offset, $limit) {
			if (isset($_SESSION["article_order"]) == false) {
				$_SESSION["article_order"] = array("title", "price");
			}

			if ((in_array($_GET["order"], $this->columns)) && ($_GET["order"] != $_SESSION["article_order"][0])) {
				$_SESSION["article_order"] = array($_GET["order"], $_SESSION["article_order"][0]);
			}

			$query = "select * from shop_articles";

			$search = array();
			if ($_SESSION["article_search"] != null) {
				foreach ($this->columns as $i => $column) {
					$this->columns[$i] = $column." like %s";
					array_push($search, "%".$_SESSION["article_search"]."%");
				}
				$query .= " having (".implode(" or ", $this->columns).")";
			}

			$query .= " order by %S,%S limit %d,%d";

			return $this->db->execute($query, $search, $_SESSION["article_order"], $offset, $limit);
		}

		public function get_article($article_id) {
			return $this->db->entry("shop_articles", $article_id);
		}

		public function save_oke($article) {
			$result = true;

			return $result;
		}

		public function create_article($article) {
			$keys = array("id", "article_nr", "title", "short_description", "long_description", "image", "price", "visible");

			$article["id"] = null;
			$article["visible"] = is_true($article["visible"]) ? YES : NO;

			return $this->db->insert("shop_articles", $article, $keys);
		}

		public function update_article($article) {
			$keys = array("article_nr", "title", "short_description", "long_description", "image", "price", "visible");

			$article["visible"] = is_true($article["visible"]) ? YES : NO;

			return $this->db->update("shop_articles", $article["id"], $article, $keys);
		}

		public function delete_oke($article) {
			$result = true;

			$query = "select count(*) as count from shop_order_article where shop_article_id=%d";
			if (($result = $this->db->execute($query, $article["id"])) === false) {
				$result = false;
			} else if ($result[0]["count"] > 0) {
				$this->output->add_message("Can't delete this article, because it's currently being ordered.");
				$result = false;
			}

			return $result;
		}

		public function delete_article($article_id) {
			return $this->db->delete("shop_articles", $article_id);
		}
	}
?>
