<?php
	class banshee_login_controller extends controller {
		public function execute() {
			header("Status: 401");

			$this->output->description = "Login";
			$this->output->keywords = "login";
			$this->output->title = "Login";

			$this->output->add_javascript("banshee/login.js");

			$bind_ip = ($_SERVER["REQUEST_METHOD"] == "POST") ? $_POST["bind_ip"] : true;

			$this->output->open_tag("login", array(
				"password" => show_boolean(module_exists("password")),
				"register" => show_boolean(module_exists("register")),
				"bind_ip"  => show_boolean($bind_ip)));

			$this->output->add_tag("url", $_SERVER["REQUEST_URI"]);

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				$this->output->add_tag("username", $_POST["username"]);
			}

			$this->output->add_tag("remote_addr", $_SERVER["REMOTE_ADDR"]);

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if (strpos($_POST["username"], "'") !== false) {
					$this->output->add_message("Sorry, this application does not support SQL injection.");
					header("X-Hiawatha-Monitor: exploit_attempt");
				} else {
					$this->output->add_message("Login incorrect");
				}
			}

			$this->output->close_tag();
		}
	}
?>
