<?php
	class demos_api_controller extends api_controller {
		public function get() {
			$this->output->add_tag("demo", "api");
		}

		public function post() {
		}
	}
?>
