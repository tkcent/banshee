<?php
	class agenda_controller extends Banshee\controller {
		private function show_month($month, $year) {
			if (($appointments = $this->model->get_appointments_for_month($month, $year)) === false) {
				$this->view->add_tag("result", "Database error.");
				return;
			}

			$day = $this->model->monday_before($month, $year);
			$last_day = $this->model->sunday_after($month, $year);
			$today = strtotime("today 00:00:00");

			$months_of_year = config_array(MONTHS_OF_YEAR);
			$this->view->open_tag("month", array("title" => $months_of_year[$month - 1]." ".$year));

			/* Links
			 */
			$y = $year;
			if (($m = $month - 1) == 0) {
				$m = 12;
				$y--;
			}
			$this->view->add_tag("prev", $y."/".$m);

			$y = $year;
			if (($m = $month + 1) == 13) {
				$m = 1;
				$y++;
			}
			$this->view->add_tag("next", $y."/".$m);

			/* Days of week
			 */
			$days_of_week = config_array(DAYS_OF_WEEK);
			$this->view->open_tag("days_of_week");
			foreach ($days_of_week as $dow) {
				if ($this->view->mobile) {
					$dow = substr($dow, 0, 3);
				}
				$this->view->add_tag("day", $dow);
			}
			$this->view->close_tag();

			/* Weeks
			 */
			while ($day < $last_day) {
				$this->view->open_tag("week");
				for ($dow = 1; $dow <= 7; $dow++) {
					$params = array("nr" => date("j", $day), "dow" => $dow);
					if ($day == $today) {
						$params["today"] = " today";
					}
					$this->view->open_tag("day", $params);

					foreach ($appointments as $appointment) {
						if (($appointment["begin"] >= $day) && ($appointment["begin"] < $day + DAY)) {
							$this->view->add_tag("appointment", $appointment["title"], array("id" => $appointment["id"]));
						} else if (($appointment["begin"] < $day) && ($appointment["end"] >= $day)) {
							$this->view->add_tag("appointment", "... ".$appointment["title"], array("id" => $appointment["id"]));
						}
					}
					$this->view->close_tag();

					$day = strtotime(date("d-m-Y", $day)." +1 day");
				}
				$this->view->close_tag();
			}
			$this->view->close_tag();
		}

		private function show_appointment($appointment_id) {
			if (($appointment = $this->model->get_appointment($appointment_id)) == false) {
				$this->view->add_tag("result", "Unknown appointment.");
				return;
			}

			$this->view->title = $appointment["title"]." - Agenda";

			$this->show_appointment_record($appointment);
		}

		private function show_appointment_record($appointment) {
			$appointment["begin"] = date("l j F Y", $appointment["begin"]);
			$appointment["end"] = date("l j F Y", $appointment["end"]);

			$this->view->record($appointment, "appointment");
		}

		public function execute() {
			$this->view->description = "Agenda";
			$this->view->keywords = "agenda";
			$this->view->title = "Agenda";

			if (isset($_SESSION["calendar_month"]) == false) {
				$_SESSION["calendar_month"] = (int)date("m");
				$_SESSION["calendar_year"]  = (int)date("Y");
			}

			if ($this->page->pathinfo[1] == "list") {
				/* Show appointment list
				 */
				if (($appointments = $this->model->get_appointments_from_today()) === false) {
					$this->view->add_tag("result", "Database error.");
				} else {
					$this->view->open_tag("list");
					foreach ($appointments as $appointment) {
						$this->show_appointment_record($appointment);
					}
					$this->view->close_tag();
				}
			} else if ($this->page->pathinfo[1] == "current") {
				/* Show current month
				 */
				$_SESSION["calendar_month"] = (int)date("m");
				$_SESSION["calendar_year"]  = (int)date("Y");
				$this->show_month($_SESSION["calendar_month"], $_SESSION["calendar_year"]);
			} else if (valid_input($this->page->pathinfo[1], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				if (valid_input($this->page->pathinfo[2], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
					$m = (int)$this->page->pathinfo[2];
					$y = (int)$this->page->pathinfo[1];

					if (($m >= 1) && ($m <= 12) && ($y > 1902) && ($y <= 2037)) {
						$_SESSION["calendar_month"] = $m;
						$_SESSION["calendar_year"]  = $y;
					}
					$this->show_month($_SESSION["calendar_month"], $_SESSION["calendar_year"]);
				} else {
					/* Show appointment
					 */
					$this->show_appointment($this->page->pathinfo[1]);
				}
			} else {
				/* Show month
				 */
				$this->show_month($_SESSION["calendar_month"], $_SESSION["calendar_year"]);
			}
		}
	}
?>
