<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class webshop_checkout_model extends Banshee\splitform_model {
		protected $forms = array(
			array(
				"template" => "address",
				"elements" => array("name", "address", "zipcode", "city", "country")),
			array(
				"template" => "payment",
				"elements" => array("creditcard")),
			array(
				"template" => "confirm",
				"elements" => array()));

		public function get_articles($article_ids) {
			if (($articles = $this->borrow("webshop/cart")->get_articles($article_ids)) === false) {
				return false;
			}

			return $articles;
		}

		public function form_data_oke($data) {
			$result = true;

			if ($this->current == 1) {
				if ($this->validate_payment($data["creditcard"]) == false) {
					$this->view->add_message("Invalid creditcard number.");
					$result = false;
				}
			}

			foreach ($this->forms[$this->current]["elements"] as $element) {
				if (trim($data[$element]) == "") {
					$this->view->add_message("The ".$element." cannot be empty.");
					$result = false;
				}
			}

			return $result;
		}

		private function validate_payment($creditcard) {
			return true;
		}

		public function place_order($order) {
			if ($this->db->query("begin") === false) {
				return false;
			}

			$data = array(
				"id" => null,
				"user_id"   => $this->user->id,
				"timestamp" => date("Y-m-d H:i:s"),
				"name"      => $order["name"],
				"address"   => $order["address"],
				"zipcode"   => $order["zipcode"],
				"city"      => $order["city"],
				"country"   => $order["country"],
				"closed"    => NO);
			if ($this->db->insert("shop_orders", $data) === false) {
				$this->db->query("rollback");
				return false;
			}
			$order_id = $this->db->last_insert_id;

			foreach ($order["articles"] as $article) {
				$data = array(
					"shop_article_id" => $article["id"],
					"shop_order_id"   => $order_id,
					"quantity"        => $article["quantity"],
					"article_price"   => $article["price"]);
				if ($this->db->insert("shop_order_article", $data) === false) {
					$this->db->query("rollback");
					return false;
				}
			}

			return $this->db->query("commit") !== false;
		}

		public function send_notification($data) {
			$notification = new Banshee\Protocols\email("Order placed", $this->settings->webmaster_email, $this->settings->head_title." webshop");
			$notification->message("Your order has been placed successfully.");

			$notification->send($this->user->email, $this->user->fullname);
		}
	}
?>
