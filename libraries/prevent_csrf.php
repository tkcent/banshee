<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	namespace Banshee;

	class prevent_CSRF {
		const TOKEN_KEY = "banshee_csrf";
		const TOKEN_MEMORY_SIZE = 10;

		private $page = null;
		private $user = null;
		private $view = null;

		/* Constructor
		 *
		 * INPUT:  object page, object user, object view
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __construct($page, $user, $view) {
			$this->page = $page;
			$this->user = $user;
			$this->view = $view;
		}

		/* Detect CSRF via HTTP Referer header
		 *
		 * INPUT:  string referer
		 * OUTPUT: boolean valid
		 * ERROR:  -
		 */
		private function detected_via_referer($referer) {
			list($protocol,, $referer_host) = explode("/", $referer, 4);
			list($referer_host) = explode(":", $referer_host);
			if (($protocol != "http:") && ($protocol != "https:")) {
				return false;
			}

			list($http_host) = explode(":", $_SERVER["HTTP_HOST"], 2);
			if ($http_host == $referer_host) {
				return false;
			}

			return true;
		}

		/* Detect CSRF via form token
		 *
		 * INPUT:  string token
		 * OUTPUT: boolean valid
		 * ERROR:  -
		 */
		private function detected_via_token() {
			if ($this->page->module == "setup") {
				return false;
			}

			$result = false;

			if (is_array($_SESSION[self::TOKEN_KEY]) == false) {
				$_SESSION[self::TOKEN_KEY] = array();
			}

			if (($_SERVER["REQUEST_METHOD"] == "POST") && ($this->page->ajax_request == false)) {
				if (in_array($_POST[self::TOKEN_KEY], $_SESSION[self::TOKEN_KEY]) == false) {
					$result = true;
				} else {
					$_SESSION[self::TOKEN_KEY] = array_diff($_SESSION[self::TOKEN_KEY], array($_POST[self::TOKEN_KEY]));
				}

				unset($_POST[self::TOKEN_KEY]);
			}

			$secret = random_string(16);
			if (count($_SESSION[self::TOKEN_KEY]) >= self::TOKEN_MEMORY_SIZE) {
				array_shift($_SESSION[self::TOKEN_KEY]);
			}
			array_push($_SESSION[self::TOKEN_KEY], $secret);

			if ($this->view->mode !== null) {
				$this->view->add_tag(self::TOKEN_KEY, $secret);
			}

			$this->view->add_javascript("banshee/prevent_csrf.js");
			$this->view->run_javascript("prevent_csrf('".self::TOKEN_KEY."', '".$secret."')");

			return $result;
		}

		/* Prevent CSRF attack
		 *
		 * INPUT:  -
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function execute() {
			if (isset($_SERVER["HTTP_ORIGIN"])) {
				$referer = $_SERVER["HTTP_ORIGIN"];
				$csrf_attack = $this->detected_via_referer($referer);
			} else if (isset($_SERVER["HTTP_REFERER"])) {
				$referer = $_SERVER["HTTP_REFERER"];
				$csrf_attack = $this->detected_via_referer($referer);
			} else {
				$referer = "previous visited website";
				$csrf_attack = $this->detected_via_token();
			}

			if ($csrf_attack) {
				/* CSRF attack detected
				 */
				$message = "CSRF attempt via %s blocked";
				$this->view->add_system_warning($message, $referer);
				$this->user->log_action($message, $referer);
				$this->user->logout();

				$_SERVER["REQUEST_METHOD"] = "GET";
				$_GET = array();
				$_POST = array();
			}
		}
	}
?>
