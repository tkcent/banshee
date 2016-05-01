<?php
	class webshop_orders_controller extends controller {
		public function execute() {
			if (isset($_SESSION["webshop_orders_closed"]) == false) {
				$_SESSION["webshop_orders_closed"] = NO;
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				$_SESSION["webshop_orders_closed"] = is_true($_POST["type"]) ? YES : NO;
			}

			$closed = $_SESSION["webshop_orders_closed"];

			if (($order_count = $this->model->count_orders($closed)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			$paging_id = "webshop_order";
			if ($closed) {	
				$paging_id .= "_closed";
			}
			$paging = new pagination($this->output, $paging_id, $this->settings->webshop_order_page_size, $order_count);

			if (($orders = $this->model->get_orders($closed, $paging->offset, $paging->size)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			$this->output->open_tag("orders", array("closed" => show_boolean($closed)));

			foreach ($orders as $order) {
				$this->output->open_tag("order");

				$order["timestamp"] = date("j F Y, H:i:s", $order["timestamp"]);
				$this->output->record($order);

				$total = 0;
				$count = 0;
				foreach ($order["articles"] as $article) {
					$total += $article["quantity"] * $article["price"];
					$count += $article["quantity"];
				}

				$this->output->open_tag("articles", array("total" => $total, "count" => $count, "currency" => WEBSHOP_CURRENCY));
				foreach ($order["articles"] as $article) {
					$this->output->record($article, "article");
				}
				$this->output->close_tag();

				$this->output->close_tag();
			}

			$paging->show_browse_links();

			$this->output->close_tag();
		}
	}
?>
