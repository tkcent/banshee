<?php
	class cms_analytics_controller extends Banshee\controller {
		private $height = 100;
		private $page_width = 839;
		private $list_limit = 15;

		private function show_graph($items, $title) {
			static $id = -1;

			$id = $id + 1;
			$max = $this->model->max_value($items, "count");

			$this->view->open_tag("graph", array("title" => $title, "id" => $id, "max" => $max));
			foreach ($items as $item) {
				if ($max > 0) {
					$item["height"] = round($this->height * ($item["count"] / $max));
				} else {
					$item["height"] = 0;
				}

				$timestamp = strtotime($item["date"]);
				$item["day"] = date("j F Y", $timestamp);
				$item["weekend"] = show_boolean(date("N", $timestamp) >= 6);

				$this->view->record($item, "item");
			}
			$this->view->close_tag();
		}

		private function show_client_info($record) {
			$highest = 0;
			$total;
			foreach ($record as $item) {
				if ($item["count"] > $highest) {
					$highest = $item["count"];
				}
				$total += $item["count"];
			}

			$this->view->open_tag("info");
			foreach ($record as $item) {
				$item["percentage"] = sprintf("%0.1f", $item["count"] * 100 / $total);
				$this->view->record($item, "item");
			}
			$this->view->close_tag();
		}

		public function execute() {
			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				$this->model->delete_referers($_POST);
			}

			$this->view->add_tag("width", floor($this->page_width / LOG_DAYS) - 1);
			$this->view->add_tag("height", $this->height);

			$this->view->add_javascript("cms/analytics.js");

			$day = valid_input($this->page->pathinfo[2], VALIDATE_NUMBERS."-", VALIDATE_NONEMPTY) ? $this->page->pathinfo[2] : null;

			/* Visits
			 */
			if (($visits = $this->model->get_visits(LOG_DAYS)) === false) {
				return false;
			}
			$this->show_graph($visits, "Visits");

			/* Page views
			 */
			if (($pageviews = $this->model->get_page_views(LOG_DAYS)) === false) {
				return false;
			}
			$this->show_graph($pageviews, "Page views");

			/* Day deselect
			 */
			if ($day !== null) {
				$this->view->add_tag("deselect", date("j F Y", strtotime($day)), array("date" => $day));
			}

			/* Top pages
			 */
			if (($pages = $this->model->get_top_pages($this->list_limit, $day)) === false) {
				return false;
			}

			$this->view->open_tag("pages");
			foreach ($pages as $page) {
				$this->view->record($page, "page");
			}
			$this->view->close_tag();

			/* Search queries
			 */
			if (($queries = $this->model->get_search_queries($this->list_limit, $day)) === false) {
				return false;
			}

			$this->view->open_tag("search");
			foreach ($queries as $query) {
				$this->view->record($query, "query");
			}
			$this->view->close_tag();

			/* Client information
			 */
			if (($browsers = $this->model->get_web_browsers($this->list_limit, $day)) === false) {
				return false;
			}

			if (($oses = $this->model->get_operating_systems($this->list_limit, $day)) === false) {
				return false;
			}

			if (($wb_os = $this->model->get_wb_os($this->list_limit, $day)) === false) {
				return false;
			}

			$this->view->open_tag("client");
			$this->show_client_info($browsers);
			$this->show_client_info($oses);
			$this->show_client_info($wb_os);
			$this->view->close_tag();

			/* Referers
			 */
			$date = date("Y-m-d", strtotime("-7 days"));
			if (($referers = $this->model->get_referers($day)) === false) {
				return false;
			}

			$this->view->open_tag("referers");
			$hostname = null;
			foreach ($referers as $hostname => $host) {
				$total = 0;
				foreach ($host as $referer) {
					$total += $referer["count"];
				}
				$params = array(
					"hostname" => $hostname,
					"count"    => count($host),
					"total"    => $total);
				$this->view->open_tag("host", $params);
				foreach ($host as $referer) {
					$this->view->record($referer, "referer");
				}
				$this->view->close_tag();
			}
			$this->view->close_tag();
		}
	}
?>
