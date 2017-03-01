<?php
	class demos_pagination_controller extends Banshee\controller {
		public function execute() {
			$this->view->title = "Pagination demo";

			$list = array();
			for ($i = 0; $i < 200; $i++) {
				array_push($list, "List item ".($i + 1));
			}

			$paging = new Banshee\pagination($this->view, "demo", 15, count($list));
			$items = array_slice($list, $paging->offset, $paging->size);

			$this->view->open_tag("items");
			foreach ($items as $item) {
				$this->view->add_tag("item", $item);
			}
			$this->view->close_tag();

			$paging->show_browse_links();
		}
	}
?>
