<?php
	class cms_webshop_article_controller extends controller {
		private function show_overview() {
			if (($article_count = $this->model->count_articles()) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			$paging = new pagination($this->output, "articles", $this->settings->admin_page_size, $article_count);

			if (($articles = $this->model->get_articles($paging->offset, $paging->size)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			$this->output->open_tag("overview");

			$this->output->open_tag("articles", array("currency" => WEBSHOP_CURRENCY));
			foreach ($articles as $article) {
				$this->output->record($article, "article");
			}
			$this->output->close_tag();

			$paging->show_browse_links();

			$this->output->close_tag();
		}

		private function show_article_form($article) {
			$this->output->open_tag("edit");
			$article["visible"] = show_boolean($article["visible"]);
			$this->output->record($article, "article");
			$this->output->close_tag();
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
							$this->output->add_message("Error creating article.");
							$this->show_article_form($_POST);
						} else {
							$this->user->log_action("article created");
							$this->show_overview();
						}
					} else {
						/* Update article
						 */
						if ($this->model->update_article($_POST) === false) {
							$this->output->add_message("Error updating article.");
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
						$this->output->add_message("Error deleting article.");
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
			} else if ($this->page->pathinfo[3] === "new") {
				/* New article
				 */
				$article = array("visible" => true);
				$this->show_article_form($article);
			} else if (valid_input($this->page->pathinfo[3], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				/* Edit article
				 */
				if (($article = $this->model->get_article($this->page->pathinfo[3])) === false) {
					$this->output->add_tag("result", "article not found.\n");
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
