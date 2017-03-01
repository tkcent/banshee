<?php
	class webshop_cart_controller extends Banshee\controller {
		private function add($article_id) {
			if (($article = $this->model->get_article($article_id)) == false) {
				$this->view->add_tag("result", "Article not found.");
				return;
			}

			if (is_array($_SESSION["webshop_cart"][$article_id]) == false) {
				$_SESSION["webshop_cart"][$article_id] = array(
					"quantity" => 1,
					"price"    => $article["price"]);
			} else {
				$_SESSION["webshop_cart"][$article_id]["quantity"]++;
			}

			$this->view->add_tag("result", "ok");

			$quantity = 0;
			foreach ($_SESSION["webshop_cart"] as $article) {
				$quantity += $article["quantity"];
			}
			$this->view->add_tag("quantity", $quantity);
		}

		public function execute() {
			if (isset($_SESSION["webshop_cart"]) == false) {
				$_SESSION["webshop_cart"] = array();
			}

			if ($this->page->ajax_request) {
				if ($this->page->pathinfo[2] == "add") {
					$this->add($this->page->pathinfo[3]);
				}
				return;
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if (is_array($_SESSION["webshop_cart"][$_POST["id"]]) == false) {
					$this->view->add_system_message("That article is no longer present in the shopping cart.");
				} else {
					if ($_POST["submit_button"] == "+") {
						$_SESSION["webshop_cart"][$_POST["id"]]["quantity"]++;
					} else if ($_POST["submit_button"] == "-") {
						if (--$_SESSION["webshop_cart"][$_POST["id"]]["quantity"] == 0) {
							unset($_SESSION["webshop_cart"][$_POST["id"]]);
						}
					}
				}
			}

			$article_ids = array_keys($_SESSION["webshop_cart"]);
			if (($articles = $this->model->get_articles($article_ids)) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$total = 0;
			$count = 0;
			foreach ($articles as $key => $article) {
				if (is_true($article["visible"])) {
					$a = &$_SESSION["webshop_cart"][$article["id"]];
					if ($article["price"] < $a["price"]) {
						$a["price"] = $article["price"];
						$this->view->add_system_message("The price of the ".$article["title"]." was lowered after you placed it in your shopping cart. Its price has been lowered accordingly.");
					}
					$total += $a["quantity"] * $a["price"];
					$count += $a["quantity"];
					unset($a);
				} else {
					/* Remove hidden article
					 */
					unset($_SESSION["webshop_cart"][$article["id"]]);
					unset($articles[$key]);
					$this->view->add_system_message("The ".$article["title"] ." has been removed from your shopping cart, as it is no longer available.");
				}

				$article_ids = array_diff($article_ids, array($article["id"]));
			}

			foreach ($article_ids as $article_id) {
				/* Remove deleted article
				 */
				unset($_SESSION["webshop_cart"][$article_id]);
				foreach ($articles as $key => $article) {
					if ($article["id"] == $article_id) {
						unset($articles[$key]);
					}
				}
				$this->view->add_system_message("An article has been removed from your shopping cart, as it is no longer available.");
			}

			if (count($articles) > 0) {
				$this->view->open_tag("cart", array(
					"currency" => WEBSHOP_CURRENCY,
					"total" => sprintf("%.2f", $total),
					"quantity" => $count));

				$total = 0;
				foreach ($articles as $article) {
					$a = $_SESSION["webshop_cart"][$article["id"]];
					$article["quantity"] = $a["quantity"];
					$article["price"] = sprintf("%.2f", $a["price"]);
					$this->view->record($article, "article");
				}

				$this->view->close_tag();
			}
		}
	}
?>
