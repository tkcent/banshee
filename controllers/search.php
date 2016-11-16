<?php
	require("../libraries/helpers/output.php");

	class search_controller extends controller {
		const MIN_QUERY_LENGTH = 3;

		private $sections = array(
			"agenda"     => "Agenda",
			"dictionary" => "Dictionary",
			"forum"      => "Forum",
			"mailbox"    => "Mailbox",
			"news"       => "News",
			"pages"      => "Pages",
			"photos"     => "Photos",
			"polls"      => "Polls",
			"weblog"     => "Weblog",
			"webshop"    => "Webshop");

		/* Search directly in database
		 */
		public function execute() {
			if ($this->user->logged_in == false) {
				unset($this->sections["mailbox"]);
			}

			if (isset($_SESSION["search"]) == false) {
				$_SESSION["search"] = array();
				foreach ($this->sections as $section => $label) {
					$_SESSION["search"][$section] = true;
				}
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				$logfile = new logfile("search");
				$logfile->add_entry($_POST["query"]);

				foreach ($this->sections as $section => $label) {
					$_SESSION["search"][$section] = is_true($_POST[$section]);
				}
			}

			$this->output->add_css("banshee/js_pagination.css");
			$this->output->add_javascript("banshee/pagination.js");
			$this->output->add_javascript("search.js");
			$this->output->run_javascript("document.getElementById('query').focus()");

			$this->output->add_tag("query", $_POST["query"]);
			$this->output->open_tag("sections");
			foreach ($this->sections as $section => $label) {
				$params = array(
					"label"   => $label,
					"checked" => show_boolean($_SESSION["search"][$section]));
				$this->output->add_tag("section", $section, $params);
			}
			$this->output->close_tag();

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if (strlen(trim($_POST["query"])) < self::MIN_QUERY_LENGTH) {
					$this->output->add_tag("result", "Search query too short.");
				} else if (($result = $this->model->search($_POST, $this->sections)) === false) {
					/* Error
					 */
					$this->output->add_tag("result", "Search error.");
				} else if (count($result) == 0) {
					$this->output->add_tag("result", "No matches found.");
				} else {
					/* Results
					 */
					foreach ($result as $section => $hits) {
						$this->output->open_tag("section", array(	
							"section" => $section,
							"label"   => $this->sections[$section]));
						foreach ($hits as $hit) {
							$hit["text"] = strip_tags($hit["text"]);
							$hit["content"] = strip_tags($hit["content"]);
							$hit["content"] = preg_replace('/\[.*?\]/', "", $hit["content"]);
							$hit["content"] = truncate_text($hit["content"], 400);
							$this->output->record($hit, "hit");
						}
						$this->output->close_tag();
					}
				}
			}
		}
	}
?>
