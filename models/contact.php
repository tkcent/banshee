<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class contact_model extends Banshee\model {
		public function contact_oke($contact) {
			$result = true;

			if (trim($contact["name"]) == "") {
				$this->view->add_message("Name cannot be empty.");
				$result = false;
			}

			if (valid_email($contact["email"]) == false) {
				$this->view->add_message("Invalid e-mail address.");
				$result = false;
			}

			if ($contact["telephone"] != "") {
				if (valid_phonenumber($contact["telephone"]) == false) {
					$this->view->add_message("Invalid telephone number.");
					$result = false;
				}
			}

			return $result;
		}

		public function send_contact($contact) {
			$email = new Banshee\email("Contact information - ".$_SERVER["SERVER_NAME"], $contact["email"], $contact["name"]);
			$email->message("The following contact information has been sent via the ".$_SERVER["SERVER_NAME"]." website:\n\n".
				"Name:      ".$contact["name"]."\n".
				"E-mail:    ".$contact["email"]."\n".
				"Telephone: ".$contact["telephone"]."\n".
				"Comment:   ".$contact["comment"]."\n");

			return $email->send($this->settings->contact_email);
		}
	}
?>
