<?php
	class admin_flag_controller extends tablemanager_controller {
		protected $name = "Flag";
		protected $pathinfo_offset = 2;
		protected $back = CMS_DIRECTORY;
		protected $icon = "flags.png";
		protected $page_size = 25;
		protected $pagination_links = 7;
		protected $pagination_step = 1;
		protected $foreign_null = "---";
		protected $browsing = "pagination";

		protected function show_item_form($item) {
			$this->output->add_javascript("jquery/jquery.js");
			$this->output->add_javascript(CMS_DIRECTORY."/flag.js");

			parent::show_item_form($item);
		}

		private function send_flags() {
			if (($flags = $this->model->get_flags($_GET["module"])) === false) {
				return;
			}

			$this->output->open_tag("flags");
			foreach ($flags as $flag) {
				$this->output->add_tag("flag", $flag, array("selected" => "no"));
			}
			$this->output->close_tag();
		}

		public function execute() {
			if ($this->page->ajax_request) {
				$this->send_flags();
			} else if (count($this->model->module_flags) == 0) {
				$this->output->open_tag("tablemanager");
				$this->output->add_tag("result", "No flags are available.", array("url" => CMS_DIRECTORY));
				$this->output->close_tag();
			} else {
				parent::execute();
			}
		}
	}
?>
