<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class contact_controller extends Banshee\controller {
		private function show_contact_form($contact) {
			$this->view->record($contact, "contact");
		}

		public function execute() {
			$this->view->description = "Contact page";
			$this->view->keywords = "contact";
			$this->view->title = "Contact";

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				/* Send contact information
				 */
				if ($this->model->contact_oke($_POST) == false) {
					$this->show_contact_form($_POST);
				} else if ($this->model->send_contact($_POST) == false) {
					$this->view->add_message("Error while sending contact information.");
					$this->show_contact_form($_POST);
				} else {
					$this->view->add_tag("result", "Your contact information has been sent to the website owner.");
				}
			} else {
				/* Show contact form
				 */
				$contact = array();
				$this->show_contact_form($contact);
			}
		}
	}
?>
