<?php
	require_once("../libraries/helpers/output.php");

	class admin_guestbook_controller extends controller {
		 public function execute() {
			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				/* Delete message
				 */
				if ($this->model->delete_message($_POST["id"])) {
					$this->user->log_action("guestbook entry %d deleted", $_POST["id"]);
				}
			}

			handle_table_sort("adminguestbook_order", array("author", "message", "timestamp", "ip_address"), array("timestamp", "author"));
			$paging = new pagination($this->output, "admin_guestbook", $this->settings->admin_page_size, $message_count);

			if (($guestbook = $this->model->get_messages($_SESSION["adminguestbook_order"], $paging->offset, $paging->size)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			$this->output->open_tag("guestbook");

			foreach ($guestbook as $item) {
				$item["message"] = truncate_text($item["message"], 45);
				$item["timestamp"] = date("j F Y, H:i", $item["timestamp"]);
				$this->output->record($item, "item");
			}

			$paging->show_browse_links();

			$this->output->close_tag();
		}
	}
?>
