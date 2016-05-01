<?php
	class cms_webshop_order_controller extends controller {
		private function show_order_overview() {
			$closed = $_SESSION["webshop_orders_closed"];

			if (($order_count = $this->model->count_orders($closed)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			$paging_id = "admin_webshop_order";
			if ($closed) {
				$paging_id .= "_closed";
			}
			$paging = new pagination($this->output, $paging_id, $this->settings->admin_page_size, $order_count);

			if (($orders = $this->model->get_orders($closed, $paging->offset, $paging->size)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			$this->output->open_tag("overview");

			$this->output->open_tag("orders", array("currency" => WEBSHOP_CURRENCY, "closed" => show_boolean($closed)));
			foreach ($orders as $order) {
				$order["timestamp"] = date("j F Y, H:i:s", $order["timestamp"]);
				$this->output->record($order, "order");
			}
			$this->output->close_tag();

			$paging->show_browse_links();

			$this->output->close_tag();
		}

		private function show_order($order_id) {
			if (($order = $this->model->get_order($order_id)) == false) {
				$this->output->add_tag("result", "Order not found.");
				return;
			}

			$this->output->open_tag("edit");

			$order["timestamp"] = date("j F Y, H:i:s", $order["timestamp"]);
			$order["closed"] = show_boolean($order["closed"]);
			$this->output->record($order, "order");

			$total = 0;
			$count = 0;
			foreach ($order["articles"] as $article) {
				$total += $article["quantity"] * $article["price"];
				$count += $article["quantity"];
			}

			$this->output->open_tag("articles", array(
				"total"    => sprintf("%.2f", $total),
				"quantity" => $count,
				"currency" => WEBSHOP_CURRENCY));
			foreach ($order["articles"] as $article) {
				$this->output->record($article, "article");
			}
			$this->output->close_tag();

			$this->output->close_tag();
		}

		public function execute() {
			if (isset($_SESSION["webshop_orders_closed"]) == false) {
				$_SESSION["webshop_orders_closed"] = NO;
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if ($_POST["submit_button"] == "type") {
					/* Change overview type
					 */
					$_SESSION["webshop_orders_closed"] = is_true($_POST["type"]) ? YES : NO;
					$this->show_order_overview();
				} else if (valid_input($_POST["id"], VALIDATE_NUMBERS, VALIDATE_NONEMPTY) == false) {
					$this->show_order_overview();
				} else if ($_POST["submit_button"] == "Close order") {
					/* Close order
					 */
					if ($this->model->close_order($_POST["id"]) == false) {
						$this->output->add_message("Error while closing order.");
						$this->show_order($_POST["id"]);
					} else {
						$this->user->log_action("order %d closed", $_POST["id"]);
						$this->show_order_overview();
					}
				} else if ($_POST["submit_button"] == "Delete order") {
					/* Delete order
					 */
					if ($this->model->delete_order($_POST["id"]) == false) {
						$this->output->add_message("Error while deleting order.");
						$this->show_order($_POST["id"]);
					} else {
						$this->user->log_action("order %d deleted", $_POST["id"]);
						$this->show_order_overview();
					}
				} else {
					$this->show_order_overview();
				}
			} else if (valid_input($this->page->pathinfo[3], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				$this->show_order($this->page->pathinfo[3]);
			} else {
				$this->show_order_overview();
			}
		}
	}
?>
