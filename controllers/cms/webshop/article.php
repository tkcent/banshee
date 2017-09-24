<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class cms_webshop_article_controller extends Banshee\controller {
		private function show_overview() {
			if (($article_count = $this->model->count_articles()) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$paging = new Banshee\pagination($this->view, "articles", $this->settings->admin_page_size, $article_count);

			if (($articles = $this->model->get_articles($paging->offset, $paging->size)) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$this->view->open_tag("overview");

			$this->view->open_tag("articles", array("currency" => WEBSHOP_CURRENCY));
			foreach ($articles as $article) {
				$this->view->record($article, "article");
			}
			$this->view->close_tag();

			$paging->show_browse_links();

			$this->view->close_tag();
		}

		private function show_article_form($article) {
			if (($categories = $this->model->get_categories()) === false) {
				$this->view->add_tag("result", "Database error.");
				return false;
			}

			if (count($categories) == 0) {
				$this->view->add_tag("result", "No article categories available. Add some first.", array("url" => "cms/webshop/category/new"));
				return true;
			}

			$this->view->open_tag("edit", array("currency" => WEBSHOP_CURRENCY));

			$article["visible"] = show_boolean($article["visible"]);
			$this->view->record($article, "article");

			$this->view->open_tag("categories");
			foreach ($categories as $category) {
				$this->view->add_tag("category", $category["name"], array("id" => $category["id"]));
			}
			$this->view->close_tag();

			$this->view->close_tag();
		}

		public function execute() {
			if ($_GET["order"] == null) {
				$_SESSION["article_search"] = null;
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if ($_POST["submit_button"] == "Save article") {
					/* Save article
					 */
					if ($this->model->save_oke($_POST) == false) {
						$this->show_article_form($_POST);
					} else if (isset($_POST["id"]) === false) {
						/* Create article
						 */
						if ($this->model->create_article($_POST) === false) {
							$this->view->add_message("Error creating article.");
							$this->show_article_form($_POST);
						} else {
							$this->user->log_action("article created");
							$this->show_overview();
						}
					} else {
						/* Update article
						 */
						if ($this->model->update_article($_POST) === false) {
							$this->view->add_message("Error updating article.");
							$this->show_article_form($_POST);
						} else {
							$this->user->log_action("article updated");
							$this->show_overview();
						}
					}
				} else if ($_POST["submit_button"] == "Delete article") {
					/* Delete article
					 */
					if ($this->model->delete_oke($_POST) == false) {
						$this->show_article_form($_POST);
					} else if ($this->model->delete_article($_POST["id"]) === false) {
						$this->view->add_message("Error deleting article.");
						$this->show_article_form($_POST);
					} else {
						$this->user->log_action("article deleted");
						$this->show_overview();
					}
				} else if ($_POST["submit_button"] == "search") {
					/* Search
					 */
					$_SESSION["article_search"] = $_POST["search"];
					$this->show_overview();
				} else {
					$this->show_overview();
				}
			} else if ($this->page->parameters[0] === "new") {
				/* New article
				 */
				$article = array("visible" => true);
				$this->show_article_form($article);
			} else if (valid_input($this->page->parameters[0], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				/* Edit article
				 */
				if (($article = $this->model->get_article($this->page->parameters[0])) == false) {
					$this->view->add_tag("result", "Article not found.\n");
				} else {
					$this->show_article_form($article);
				}
			} else {
				/* Show overview
				 */
				$this->show_overview();
			}
		}
	}
?>
