<?php
	class collection_controller extends Banshee\controller {
		private $title = "Photo album collections";

		private function show_collection_overview() {
			if (($collections = $this->model->get_collections()) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			} else if (count($collections) == 0) {
				$this->view->add_tag("result", "No photo album collections are available.", array("seconds" => 0));
				return;
			}

			$this->view->open_tag("overview");

			$this->view->open_tag("collections");
			foreach ($collections as $collection) {
				$this->view->record($collection, "collection");
			}
			$this->view->close_tag();

			$this->view->close_tag();
		}

		private function show_collection($collection) {
			$this->title = $collection["name"];

			$this->view->open_tag("collection");
			foreach ($collection["albums"] as $album) {
				$this->view->record($album, "album");
			}
			$this->view->close_tag();
		}

		public function execute() {
			if (valid_input($this->page->pathinfo[1], VALIDATE_NUMBERS, VALIDATE_NONEMPTY) == false) {
				$this->show_collection_overview();
			} else if (($collection = $this->model->get_collection($this->page->pathinfo[1])) == false) {
				$this->view->add_tag("result", "Collection not found.");
			} else {
				$this->show_collection($collection);
			}

			$this->view->add_tag("title", $this->title);
			$this->view->title = $this->title;
		}
	}
?>
