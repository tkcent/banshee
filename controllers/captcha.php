<?php
	class captcha_controller extends Banshee\controller {
		public function execute() {
			$captcha = new Banshee\captcha;
			if ($captcha->created == false) {
				exit;
			}

			$this->view->disable();
			$captcha->to_output();
		}
	}
?>
