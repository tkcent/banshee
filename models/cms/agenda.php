<?php
	class cms_agenda_model extends model {
		public function get_appointments() {
			$query = "select * from agenda order by begin,end";

			return $this->db->execute($query);
		}

		public function get_appointment($appointment_id) {
			$query = "select * from agenda where id=%d";

			if (($result = $this->db->execute($query, $appointment_id)) == false) {
				return false;
			}

			return $result[0];
		}

		public function appointment_oke($appointment) {
			$result = true;

			if (valid_date($appointment["begin"]) == false) {
				$this->output->add_message("Invalid start time.");
				$result = false;
			}
			if (valid_date($appointment["end"]) == false) {
				$this->output->add_message("Invalid end time.");
				$result = false;
			}

			if ($result) {
				if (strtotime($appointment["begin"]) > strtotime($appointment["end"])) {
					$this->output->add_message("Begin date must lie before end date.");
					$result = false;
				}
			}

			if (trim($appointment["title"]) == "") {
				$this->output->add_message("Empty short description not allowed.");
				$result = false;
			}

			return $result;
		}

		public function create_appointment($appointment) {
			$keys = array("id", "begin", "end", "title", "content");
			$appointment["id"] = null;

			return $this->db->insert("agenda", $appointment, $keys) !== false;
		}

		public function update_appointment($appointment) {
			$keys = array("begin", "end", "title", "content");

			return $this->db->update("agenda", $appointment["id"], $appointment, $keys) !== false;
		}

		public function delete_appointment($appointment_id) {
			return $this->db->delete("agenda", $appointment_id);
		}
	}
?>
