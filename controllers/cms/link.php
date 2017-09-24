<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class cms_link_controller extends Banshee\controller {
		private function show_overview() {
			if (($link_count = $this->model->count_links()) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$paging = new Banshee\pagination($this->view, "links", $this->settings->admin_page_size, $link_count);

			if (($links = $this->model->get_links($paging->offset, $paging->size)) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$this->view->open_tag("overview");

			$this->view->open_tag("links");
			foreach ($links as $link) {
				$this->view->record($link, "link");
			}
			$this->view->close_tag();

			$paging->show_browse_links();

			$this->view->close_tag();
		}

		private function show_link_form($link) {
			if (($categories = $this->model->get_categories()) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			if (count($categories) == 0) {
				$this->view->add_tag("result", "Add a category first.", array("url" => "cms/link/category/new"));
				return;
			}

			$this->view->open_tag("edit");

			$this->view->open_tag("categories");
			foreach ($categories as $category) {
				$this->view->add_tag("category", $category["category"], array("id" => $category["id"]));
			}
			$this->view->close_tag();

			$this->view->record($link, "link");

			$this->view->close_tag();
		}

		public function execute() {
			if ($_GET["order"] == null) {
				$_SESSION["link_search"] = null;
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if ($_POST["submit_button"] == "Save link") {
					/* Save link
					 */
					if ($this->model->save_oke($_POST) == false) {
						$this->show_link_form($_POST);
					} else if (isset($_POST["id"]) === false) {
						/* Create link
						 */
						if ($this->model->create_link($_POST) === false) {
							$this->view->add_message("Error creating link.");
							$this->show_link_form($_POST);
						} else {
							$this->user->log_action("link created");
							$this->show_overview();
						}
					} else {
						/* Update link
						 */
						if ($this->model->update_link($_POST) === false) {
							$this->view->add_message("Error updating link.");
							$this->show_link_form($_POST);
						} else {
							$this->user->log_action("link updated");
							$this->show_overview();
						}
					}
				} else if ($_POST["submit_button"] == "Delete link") {
					/* Delete link
					 */
					if ($this->model->delete_oke($_POST) == false) {
						$this->show_link_form($_POST);
					} else if ($this->model->delete_link($_POST["id"]) === false) {
						$this->view->add_message("Error deleting link.");
						$this->show_link_form($_POST);
					} else {
						$this->user->log_action("link deleted");
						$this->show_overview();
					}
				} else if ($_POST["submit_button"] == "search") {
					/* Search
					 */
					$_SESSION["link_search"] = $_POST["search"];
					$this->show_overview();
				} else {
					$this->show_overview();
				}
			} else if ($this->page->parameters[0] === "new") {
				/* New link
				 */
				$link = array("category_type" => "existing");
				$this->show_link_form($link);
			} else if (valid_input($this->page->parameters[0], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				/* Edit link
				 */
				if (($link = $this->model->get_link($this->page->parameters[0])) == false) {
					$this->view->add_tag("result", "Link not found.");
				} else {
					$link["category_type"] = "existing";
					$this->show_link_form($link);
				}
			} else {
				/* Show overview
				 */
				$this->show_overview();
			}
		}
	}
?>
