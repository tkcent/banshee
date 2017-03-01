<?php
	class webshop_controller extends Banshee\controller {
		public function show_articles($search, $category) {
			if (($article_count = $this->model->count_articles($search, $category)) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$paging = new Banshee\pagination($this->view, "webshop_articles", $this->settings->webshop_page_size, $article_count);

			if (($articles = $this->model->get_articles($paging->offset, $paging->size, $search, $category)) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if (($art_count = count($articles)) == 0) {
					$this->view->add_tag("result", "No matching articles have been found.");
					$_SESSION["webshop_search"] = null;
					return;
				}

				$_SESSION["webshop_search_count"] = $art_count;
				if (($search != "") && ($_SESSION["webshop_search_count"] == 1)) {
					$this->show_article($articles[0]);
					return;
				}
			}

			if (($categories = $this->model->get_categories()) == false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$this->view->open_tag("webshop");

			$this->view->open_tag("categories", array("current" => (int)$_SESSION["webshop_category"]));
			foreach ($categories as $category) {
				$this->view->add_tag("category", $category["name"], array("id" => $category["id"]));
			}
			$this->view->close_tag();

			$this->view->open_tag("articles", array("currency" => WEBSHOP_CURRENCY));
			foreach ($articles as $article) {
				$article["price"] = sprintf("%.2f", $article["price"]);
				$this->view->record($article, "article");
			}
			$this->view->close_tag();

			$paging->show_browse_links();

			$this->view->close_tag();
		}

		public function show_article($article) {
			$this->view->add_javascript("banshee/notify.js");
			$this->view->add_javascript("webshop.js");

			$article["price"] = sprintf("%.2f", $article["price"]);
			$this->view->record($article, "article", array("currency" => WEBSHOP_CURRENCY));
		}

		public function execute() {
			if (isset($_SESSION["webshop_cart"]) == false) {
				$_SESSION["webshop_cart"] = array();
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if ($_POST["submit_button"] == "search") {
					$_SESSION["webshop_search"] = $_POST["search"];
				}
			} else if (($this->page->pathinfo[1] == null) && ($_SESSION["webshop_search_count"] === 1)) {
				$_SESSION["webshop_search"] = null;
				$_SESSION["webshop_search_count"] = null;
			}

			if ($this->page->pathinfo[1] == "category") {
				if ($this->page->pathinfo[2] == 0) {
					$_SESSION["webshop_category"] = null;
				} else if (valid_input($this->page->pathinfo[2], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
					$_SESSION["webshop_category"] = $this->page->pathinfo[2];
				} else {
					$_SESSION["webshop_category"] = null;
				}
			}

			$cart_count = 0;
			foreach ($_SESSION["webshop_cart"] as $article) {
				$cart_count += $article["quantity"];
			}
			$this->view->add_tag("cart", $cart_count);

			$this->view->add_tag("search", $_SESSION["webshop_search"]);

			if (valid_input($this->page->pathinfo[1], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				if (($article = $this->model->get_article($this->page->pathinfo[1])) !== false) {
					$this->show_article($article);
				} else {
					$this->view->add_tag("result", "Article not found.");
				}
			} else {
				$this->show_articles($_SESSION["webshop_search"], $_SESSION["webshop_category"]);
			}
		}
	}
?>
