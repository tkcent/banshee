<?php
	class webshop_checkout_controller extends splitform_controller {
		protected $back = "webshop/cart";
		protected $button_submit = "Place order";

		protected function prepare_confirm() {
			foreach ($this->model->forms[0]["elements"] as $item) {
				$this->output->add_tag($item, $_SESSION["splitform"][$this->page->module]["values"][$item]);
			}

			$article_ids = array_keys($_SESSION["webshop_cart"]);
			if (($articles = $this->model->get_articles($article_ids)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			$total = 0;
			$count = 0;
			foreach ($articles as $key => $article) {
				if (is_true($article["visible"])) {
					$a = &$_SESSION["webshop_cart"][$article["id"]];
					if ($article["price"] < $a["price"]) {
						$a["price"] = $article["price"];
						$this->output->add_system_message("The price of the ".$article["title"]." was lowered during your checkout. Its price has been lowered accordingly.");
					}
					$total += $a["quantity"] * $a["price"];
					$count += $a["quantity"];
					unset($a);
				} else {
					/* Remove hidden article
					 */
					unset($_SESSION["webshop_cart"][$article["id"]]);
					unset($articles[$key]);
					$this->output->add_system_message("The ".$article["title"] ." has been removed from your shopping cart, as it is no longer available.");
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
				$this->output->add_system_message("An article has been removed from your shopping cart, as it is no longer available.");
			}

			$this->output->open_tag("cart", array(
				"currency" => WEBSHOP_CURRENCY,
				"total" => sprintf("%.2f", $total),
				"quantity" => $count));
			$total = 0;
			foreach ($articles as $article) {
					$a = $_SESSION["webshop_cart"][$article["id"]];
				$article["quantity"] = $a["quantity"];
				$article["price"] = sprintf("%.2f", $a["price"]);
				$this->output->record($article, "article");
			}

			$this->output->close_tag();
		}

		protected function process_form_data($data) {
			$article_ids = array_keys($_SESSION["webshop_cart"]);
			if (($data["articles"] = $this->model->get_articles($article_ids)) === false) {
				$this->output->add_tag("result", "Database error.");
				return;
			}

			foreach ($data["articles"] as $key => $article) {
				$a = $_SESSION["webshop_cart"][$article["id"]];
				$data["articles"][$key]["quantity"] = $a["quantity"];
				$data["articles"][$key]["price"] = $a["price"];
			}

			if (count($data["articles"]) == 0) {
				$this->output->add_tag("result", "Your shopping cart is empty!", array("url" => "webshop"));
			} else if ($this->model->place_order($data) == false) {
				$this->output->add_message("Error while placing order!");
				return false;
			} else {
				$this->model->send_notification($data);
			}

			$_SESSION["webshop_cart"] = array();

			return true;
		}

		public function execute() {
			if (count($_SESSION["webshop_cart"]) > 0) {
				$this->model->default_value("name", $this->user->fullname);
				$this->model->default_value("country", "The Netherlands");
				parent::execute();
			} else {
				$this->output->add_tag("result", "Your shopping cart is empty!", array("url" => "webshop"));
			}
		}
	}
?>
