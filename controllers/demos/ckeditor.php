<?php
	class demos_ckeditor_controller extends Banshee\controller {
		public function execute() {
			$this->view->title = "CKEditor demo";

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				$this->view->open_tag("result");
				$this->view->add_tag("editor", $_POST["editor"]);
				$this->view->close_tag();
			} else {
				$this->view->add_ckeditor();
#				$this->view->add_ckeditor("div.btn-group");

				$this->view->add_tag("edit");
			}
		}
	}
?>
