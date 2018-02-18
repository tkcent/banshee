<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	namespace Banshee\Protocols;

	class NMA {
		const NMA_SERVER = "www.notifymyandroid.com";

		private $api = null;
		private $application = null;
		private $api_keys = null;
		private $developer_key = null;

		/* Constructor
		 *
		 * INPUT:  string application, array/string API keys[, string developer key]
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __construct($application, $api_keys, $developer_key = null) {
			$this->application = $this->truncate($application, 256);
			if (is_array($api_keys) == false) {
				$this->api_keys = array($api_keys);
			} else {
				$this->api_keys = $api_keys;
			}
			$this->developer_key = $developer_key;

			$this->api = new HTTPS(self::NMA_SERVER);
		}

		/* Truncate text
		 *
		 * INPUT:  string text, integer maximum text length
		 * OUTPUT: string truncated text
		 * ERROR:  -
		 */
		private function truncate($text, $size) {
			if (strlen($text) > $size) {
				$text = substr($text, 0, $size - 3)."...";
			}

			return $text;
		}

		/* Send push notification
		 *
		 * INPUT:  string event, string description[, int priority[, string url[, string content type]]]
		 * OUTPUT: true sending successful
		 * ERROR:  false sending failed
		 */
		public function send_notification($event, $description, $priority = 0, $url = null, $content_type = null) {
			if ((is_int($priority) == false) || ($priority < -2) || ($priority > 2)) {
				return false;
			}

			$data = array(
				"apikey"      => implode(",", $this->api_keys),
				"application" => $this->application,
				"event"       => $this->truncate($event, 1000),
				"description" => $this->truncate($description, 10000));

			if ($priority != 0) {
				$data["priority"] = $priority;
			}

			if ($url !== null) {
				$data["url"] = $this->truncate($url, 512);
			}

			if ($this->developer_key !== null) {
				$data["developerkey"] = $this->developer_key;
			}

			if ($content_type !== null) {
				$data["content-type"] = $content_type;
			}

			if (($result = $this->api->POST("/publicapi/notify", $data)) === false) {
				return false;
			}

			return $result["status"];
		}

		/* Verify API key
		 *
		 * INPUT:  string API key
		 * OUTPUT: bool valid key
		 * ERROR:  null validation error
		 */
		public function valid_key($api_key) {
			$params = "apikey=".$api_key;

			if ($this->developer_key !== null) {
				$params .= "&developerkey=".$this->developer_key;
			}

			if (($result = $this->api->GET("/publicapi/verify?".$params)) === false) {
				return false;
			}

			return $result["status"];
		}
	}
?>
