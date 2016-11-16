<?php
	/* libraries/analytics.php
	 *
	 * Copyright (C) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * http://www.banshee-php.org/
	 */
	class analytics {
		private $db = null;
		private $page = null;
		private $today = null;
		private $search_bots = array("bot", "spider", "crawl", "feed", "rss", "slurp",
			"thumbshots", "sogou", "claws", "wotbox", "Blogtrottr");
		private $search_urls = array("www.google.", "www.bing.com", "duckduckgo.com");
		private $referer_spam = array("viagra", "pharma", "cheap");
		private $operating_systems = array("Windows", "Linux", "FreeBSD", "Android",
			"iPhone" => "iOS", "iPad" => "iOS", "Mac OS X");
		private $web_browsers = array("Firefox", "Chrome", "MSIE" => "Internet Explorer",
			"Safari", "Opera", "Webkit", "Gecko", "Wget", "curl", "Lynx", "Links");

		/* Constructor
		 *
		 * INPUT:  object database, object page
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __construct($db, $page) {
			$this->db = $db;
			$this->page = $page;
		}

		/* Log visit
		 *
		 * INPUT:  -
		 * OUTPUT: -
		 * ERROR:  -
		 */
		private function log_visit() {
			$query = "update log_visits set count=count+1 where date=%s";
			if (($result = $this->db->execute($query, $this->today)) === false) {
				return;
			} else if ($result > 0) {
				return;
			}

			$data = array(
				"id"    => null,
				"date"  => $this->today,
				"count" => 1);
			$this->db->insert("log_visits", $data);
		}

		/* Log search query
		 *
		 * INPUT:  string url
		 * OUTPUT: -
		 * ERROR:  -
		 */
		private function log_search_query($url) {
			list(, $params) = explode("?", $url, 2);
			if ($params == null) {
				return;
			}

			$get = array();
			$parts = explode("&", $params);
			foreach ($parts as $part) {
				list($key, $value) = explode("=", $part);
				$get[$key] = $value;
			}

			$search = null;
			if (isset($get["q"])) {
				$search = urldecode($get["q"]);
			}

			if ($search == null) {
				return;
			}

			$query = "update log_search_queries set count=count+1 where query=%s and date=%s";
			if (($result = $this->db->execute($query, $search, $this->today)) === false) {
				return;
			} else if ($result > 0) {
				return;
			}

			$data = array(
				"id"    => null,
				"query" => $search,
				"date"  => $this->today,
				"count" => 1);
			$this->db->insert("log_search_queries", $data);
		}

		/* Log referer
		 *
		 * INPUT:  string referer
		 * OUTPUT: -
		 * ERROR:  -
		 */
		private function log_referer($referer) {
			list(,, $hostname, $path) = explode("/", $referer, 4);
			list($hostname) = explode(":", $hostname);

			$dont_log = array(WEBSITE_DOMAIN, $_SERVER["HTTP_HOST"], $_SERVER["SERVER_NAME"], "localhost", "127.0.0.1", "");
			if (in_array($hostname, $dont_log)) {
				return;
			}

			$lans = array("192.168.", "10.", "172.16.");
			foreach ($lans as $lan) {
				if (substr($hostname, 0, strlen($lan)) == $lan) {
					return;
				}
			}

			foreach ($this->referer_spam as $spam) {
				if (strpos($hostname, $spam) !== false) {
					return;
				}
			}

			list($referer) = explode("#", $referer, 2);

			$query = "update log_referers set count=count+1 where hostname=%s and url=%s and date=%s";
			if (($result = $this->db->execute($query, $hostname, $referer, $this->today)) === false) {
				return;
			} else if ($result > 0) {
				return;
			}

			$data = array(
				"id"       => null,
				"hostname" => $hostname,
				"url"      => $referer,
				"date"     => $this->today,
				"count"    => 1);
			$this->db->insert("log_referers", $data);
		}

		/* Log client information
		 *
		 * INPUT:  string user agent
		 * OUTPUT: -
		 * ERROR:  -
		 */
		private function log_client($user_agent) {
			if ($user_agent == null) {
				return;
			}

			$operating_system = $web_browser = "Other";

			foreach ($this->operating_systems as $key => $value) {
				if (is_int($key)) {
					$key = $value;
				}

				if (strpos($user_agent, $key) !== false) {
					$operating_system = $value;
					break;
				}
			}

			foreach ($this->web_browsers as $key => $value) {
				if (is_int($key)) {
					$key = $value;
				}

				if (strpos($user_agent, $key) !== false) {
					$web_browser = $value;
					break;
				}
			}

			$query = "update log_clients set count=count+1 where os=%s and browser=%s and date=%s";
			if (($result = $this->db->execute($query, $operating_system, $web_browser, $this->today)) === false) {
				return;
			} else if ($result > 0) {
				return;
			}

			$data = array(
				"id"      => null,
				"os"      => $operating_system,
				"browser" => $web_browser,
				"date"    => $this->today,
				"count"   => 1);
			$this->db->insert("log_clients", $data);
		}

		/* Log page view
		 *
		 * INPUT:  string page
		 * OUTPUT: -
		 * ERROR:  -
		 */
		private function log_page_view($page) {
			$query = "update log_page_views set count=count+1 where page=%s and date=%s";
			if (($result = $this->db->execute($query, $page, $this->today)) === false) {
				return;
			} else if ($result > 0) {
				return;
			}

			$data = array(
				"id"    => null,
				"page"  => $page,
				"date"  => $this->today,
				"count" => 1);
			$this->db->insert("log_page_views", $data);
		}

		/* Execute logging
		 *
		 * INPUT:  -
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function execute() {
			if ($this->page->ajax_request) {
				return;
			}

			if (isset($_SERVER["HTTP_USER_AGENT"]) == false) {
				return;
			}

			/* Don't log hits from search bots
			 */
			foreach ($this->search_bots as $bot) {
				if (strpos(strtolower($_SERVER["HTTP_USER_AGENT"]), $bot) !== false) {
					return;
				}
			}

			/* Don't log visits of admin and system pages
			 */
			$skip_pages = array("cms");
			if (in_array($this->page->page, $skip_pages)) {
				return;
			} else if (substr($this->page->page, 0, 6) == "cms/") {
				return;
			}

			$this->today = date("Y-m-d");

			/* Log visit and client
			 */
			if (isset($_SESSION["last_visit"]) == false) {
				$this->log_visit();
				$this->log_client($_SERVER["HTTP_USER_AGENT"]);
			}

			if (isset($_SERVER["HTTP_REFERER"])) {
				/* Log search query
				 */
				$search_referer = false;
				foreach ($this->search_urls as $url) {
					if (strpos($_SERVER["HTTP_REFERER"], $url) !== false) {
						$this->log_search_query($_SERVER["HTTP_REFERER"]);
						$search_referer = true;
						break;
					}
				}

				/* Log referer
				 */
				if ($search_referer == false) {
					$this->log_referer($_SERVER["HTTP_REFERER"]);
				}
			}

			/* Log page view
			 */
			$this->log_page_view($this->page->page);
		}
	}
?>
