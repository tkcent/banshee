<?php
	class webshop_controller extends controller {
		public function show_articles($search) {
			if (($article_count = $this->model->count_articles($search)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;	
			}

			$paging = new pagination($this->output, "webshop_articles", $this->settings->webshop_page_size, $article_count);

			if (($articles = $this->model->get_articles($paging->offset, $paging->size, $search)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;	
			}

			$this->output->open_tag("webshop");

			$this->output->open_tag("articles", array("currency" => WEBSHOP_CURRENCY));
			foreach ($articles as $article) {
				$article["price"] = sprintf("%.2f", $article["price"]);
				$this->output->record($article, "article");
			}
			$this->output->close_tag();

			$paging->show_browse_links();

			$this->output->close_tag();
		}

		public function show_article($article) {
			$this->output->add_javascript("banshee/notify.js");
			$this->output->add_javascript("webshop.js");

			$article["price"] = sprintf("%.2f", $article["price"]);
			$this->output->record($article, "article", array("currency" => WEBSHOP_CURRENCY));
		}

		public function execute() {
			if (isset($_SESSION["webshop_cart"]) == false) {
				$_SESSION["webshop_cart"] = array();
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if ($_POST["submit_button"] == "search") {
					/* Search
					 */
					$_SESSION["webshop_search"] = $_POST["search"];
				}
			}

			$cart_count = 0;
			foreach ($_SESSION["webshop_cart"] as $article) {
				$cart_count += $article["quantity"];
			}
			$this->output->add_tag("cart", $cart_count);

			$this->output->add_tag("search", $_SESSION["webshop_search"]);

			if (valid_input($this->page->pathinfo[1], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				if (($article = $this->model->get_article($this->page->pathinfo[1])) !== false) {
					$this->show_article($article);
				} else {
					$this->output->add_tag("result", "Article not found.");
				}
			} else {
				$this->show_articles($_SESSION["webshop_search"]);
			}
		}
	}
?>
