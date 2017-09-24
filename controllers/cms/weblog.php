<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	require_once("../libraries/helpers/output.php");

	class cms_weblog_controller extends Banshee\controller {
		private function show_weblog_overview() {
			if (($weblog_count = $this->model->count_weblogs()) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$paging = new Banshee\pagination($this->view, "admin_forum", $this->settings->admin_page_size, $weblog_count);

			if (($weblogs = $this->model->get_weblogs($paging->offset, $paging->size)) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$this->view->open_tag("overview");

			$this->view->open_tag("weblogs");
			foreach ($weblogs as $weblog) {
				$weblog["visible"] = show_boolean($weblog["visible"]);
				$weblog["timestamp"] = date("j F Y, H:i", $weblog["timestamp"]);
				$this->view->record($weblog, "weblog");
			}
			$this->view->close_tag();

			$paging->show_browse_links();

			$this->view->add_tag("comments", show_boolean($this->user->access_allowed("cms/weblog/comment")));

			$this->view->close_tag();
		}

		private function show_weblog_form($weblog) {
			$this->view->add_ckeditor("div.btn-group");

			$this->view->open_tag("edit");

			$weblog["visible"] = show_boolean($weblog["visible"]);
			$this->view->record($weblog, "weblog");

			/* Tags
			 */
			$tagged = array();
			if (isset($weblog["tag"])) {
				$tagged = $weblog["tag"];
			} else if (($weblog_tags = $this->model->get_weblog_tags($weblog["id"])) != false) {
				foreach ($weblog_tags as $tag) {
					array_push($tagged, $tag["id"]);
				}
			}

			$this->view->open_tag("tags");
			if (($tags = $this->model->get_tags()) != false) {
				foreach ($tags as $tag) {
					$this->view->add_tag("tag", $tag["tag"], array(
						"id" => $tag["id"],
						"selected" => show_boolean(in_array($tag["id"], $tagged))));
				}
			}
			$this->view->close_tag();

			/* Comments
			 */
			$this->view->open_tag("comments");
			if (($weblog_comments = $this->model->get_weblog_comments($weblog["id"])) != false) {
				foreach ($weblog_comments as $comment) {
					$comment["content"] = truncate_text($comment["content"], 100);
					$this->view->record($comment, "comment");
				}
			}
			$this->view->close_tag();

			$this->view->close_tag();
		}

		public function execute() {
			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				/* Remove weblog RSS from cache
				 */
				$this->view->remove_from_cache("weblog_rss");

				if ($_POST["submit_button"] == "Save weblog") {
					/* Save weblog
					 */
					if ($this->model->save_oke($_POST) == false) {
						$this->show_weblog_form($_POST);
					} else if (isset($_POST["id"]) == false) {
						/* Create weblog
						 */
						if ($this->model->create_weblog($_POST) == false) {
							$this->view->add_message("Database error while creating weblog.");
							$this->show_weblog_form($_POST);
						} else {
							$this->user->log_action("weblog %d created", $this->db->last_insert_id);
							$this->show_weblog_overview();
						}
					} else {
						/* Update weblog
						 */
						if ($this->model->update_weblog($_POST) == false) {
							$this->view->add_message("Database error while updating weblog.");
							$this->show_weblog_form($_POST);
						} else {
							$this->user->log_action("weblog %d updated", $_POST["id"]);
							$this->show_weblog_overview();
						}
					}
				} else if ($_POST["submit_button"] == "Delete weblog") {
					/* Delete weblog
					 */
					if ($this->model->delete_weblog($_POST["id"]) == false) {
						$this->view->add_tag("result", "Error while deleting weblog.");
					} else {
						$this->user->log_action("weblog %d deleted", $_POST["id"]);
						$this->show_weblog_overview();
					}
				} else {
					$this->show_weblog_overview();
				}
			} else if (valid_input($this->page->parameters[0], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				/* Show weblog
				 */
				if (($weblog = $this->model->get_weblog($this->page->parameters[0])) == false) {
					$this->view->add_tag("result", "Weblog not found.");
				} else {
					$this->show_weblog_form($weblog);
				}
			} else if ($this->page->parameters[0] == "new") {
				/* New weblog
				 */
				$weblog = array(
					"visible" => 1);
				$this->show_weblog_form($weblog);
			} else {
				/* Show weblog overview
				 */
				$this->show_weblog_overview();
			}
		}
	}
?>
