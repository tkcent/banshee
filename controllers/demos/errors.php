<?php
	class demos_errors_controller extends Banshee\controller {
		public function execute() {
			$this->view->title = "Error demo";

			print "These are error messages caused by PHP errors:\n";
			$result = 1 / 0;
			$result = substr();

			$this->view->add_system_message("This is a system message.");
			$this->view->add_system_warning("This is a system warning.");
		}
	}
?>
