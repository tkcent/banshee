<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class profile_controller extends Banshee\controller {
		private function show_profile_form($profile = null) {
			if ($profile === null) {
				$profile = array(
					"fullname" => $this->user->fullname,
					"email"    => $this->user->email);
			}

			if (($organisation = $this->model->get_organisation()) === false) {
				$this->view->add_tag("result", "Database error.");
				return false;
			}

			$this->view->open_tag("edit");

			$this->view->add_tag("username", $this->user->username);
			$this->view->add_tag("fullname", $profile["fullname"]);
			$this->view->add_tag("organisation", $organisation);
			$this->view->add_tag("email", $profile["email"]);
			if ($this->user->status == USER_STATUS_CHANGEPWD) {
				$this->view->add_tag("cancel", "Logout", array("previous" => LOGOUT_MODULE));
			} else {
				$this->view->add_tag("cancel", "Back", array("previous" => $this->page->previous));
			}

			/* Action log
			 */
			if (($actionlog = $this->model->last_account_logs()) !== false) {
				$this->view->open_tag("actionlog");
				foreach ($actionlog as $log) {
					$this->view->record($log, "log");
				}
				$this->view->close_tag();
			}

			$this->view->close_tag();
		}

		public function execute() {
			if ($this->user->logged_in == false) {
				$this->view->add_tag("result", "You are not logged in!", array("url" => $this->settings->start_page));
				return;
			}

			$this->view->description = "Profile";
			$this->view->keywords = "profile";
			$this->view->title = "Profile";

			if ($this->user->status == USER_STATUS_CHANGEPWD) {
				$this->view->add_message("Please, change your password.");
			}

			if (isset($_SESSION["profile_next"]) == false) {
				if ($this->page->pathinfo[0] == "profile") {
					$_SESSION["profile_next"] = $this->settings->start_page;
				} else {
					$_SESSION["profile_next"] = substr($_SERVER["REQUEST_URI"], 1);
				}
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				/* Update profile
				 */
				if ($_POST["submit_button"] == "Update profile") {
					if ($this->model->profile_oke($_POST) == false) {
						$this->show_profile_form($_POST);
					} else if ($this->model->update_profile($_POST) === false) {
						$this->view->add_tag("result", "Error while updating profile.", array("url" => "profile"));
					} else {
						$this->view->add_tag("result", "Profile has been updated.", array("url" => $_SESSION["profile_next"]));
						$this->user->log_action("profile updated");
						unset($_SESSION["profile_next"]);
					}
				} else if ($_POST["submit_button"] == "Delete profile") {
					if ($this->model->delete_account() == false) {
						$this->view->add_message("Something went wrong while deleting this account.");
						$this->show_profile_form();
					} else {
						$this->view->add_tag("result", "Your account has been deleted. You will be logged out.", array("url" => ""));
						$this->user->logout();
					}
				}
			} else {
				$this->show_profile_form();
			}
		}
	}
?>
