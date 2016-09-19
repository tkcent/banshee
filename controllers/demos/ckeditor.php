<?php
	class demos_ckeditor_controller extends controller {
		public function execute() {
			$this->output->title = "CKEditor demo";

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				$this->output->open_tag("result");
				$this->output->add_tag("editor", $_POST["editor"]);
				$this->output->close_tag();
			} else {
				$this->output->add_ckeditor();
#				$this->output->add_ckeditor("div.btn-group");

				$this->output->add_tag("edit");
			}
		}
	}
?>
