<?php
	class poll_controller extends Banshee\controller {
		public function show_active_poll() {
			$poll = new Banshee\poll($this->db, $this->view, $this->settings);

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				$poll->vote($_POST["vote"]);
			}

			$poll->to_output();
		}

		public function execute() {
			$this->view->description = "Poll";
			$this->view->keywords = "poll";

			if (valid_input($this->page->pathinfo[1], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				/* Show poll
				 */
				if (($poll = $this->model->get_poll($this->page->pathinfo[1])) == false) {
					$this->view->add_tag("result", "Poll not found");
				} else {
					$this->view->title = $poll["question"]." - Poll";

					$this->view->open_tag("poll", array("id" => $poll["id"]));
					$this->view->add_tag("question", $poll["question"]);

					$votes = 0;
					foreach ($poll["answers"] as $answer) {
						$votes += (int)$answer["votes"];
					}

					$this->view->open_tag("answers", array("votes" => $votes));
					foreach ($poll["answers"] as $answer) {
						unset($answer["poll_id"]);
						$answer["percentage"] = ($votes > 0) ? round(100 * (int)$answer["votes"] / $votes) : 0;
						$this->view->record($answer, "answer");
					}
					$this->view->close_tag();

					$this->view->close_tag();
				}
			} else {
				$this->show_active_poll();

				/* Poll overview
				 */
				$this->view->title = "Poll";

				if (($polls = $this->model->get_polls()) === false) {
					$this->view->add_tag("result", "Database error");
				} else {
					$active_poll_id = $this->model->get_active_poll_id();

					$this->view->open_tag("polls");
					foreach ($polls as $poll) {
						if ($poll["id"] != $active_poll_id) {
							$this->view->add_tag("question", $poll["question"], array("id" => $poll["id"]));
						}
					}
					$this->view->close_tag();
				}
			}
		}
	}
?>
