<?php
	class demos_googlemaps_controller extends Banshee\controller {
		private $origin = "Amsterdam, NL";
		private $destination = "Paris, FR";

		private function show_static_map() {
			$google_map = new Banshee\Google_Maps($this->db);

			$google_map->add_route($this->origin, $this->destination);

			$google_map->add_marker("D", "red", "Den Haag, NL");
			$google_map->add_marker("L", "yellow", "London, EN");
			$google_map->add_marker("B", "green", "Bonn, DE");

			$google_map->set_visibility("Stuttgart, DE");

			$this->view->disable();
			$google_map->show_static_map(640, 350);
		}

		public function execute() {
			if ($this->page->pathinfo[2] == "image") {
				$this->show_static_map();
				return;
			}

			$google_map = new Banshee\Google_Maps($this->db);

			$google_map->add_route($this->origin, $this->destination);
			$steps = $google_map->route_description;
			$distance = $google_map->route_distance;
			$duration = $google_map->route_duration;

			$hours = $duration / 3600;
			$minutes = ($duration % 3600) / 60;

			$this->view->open_tag("route");

			$this->view->add_tag("origin", $this->origin);
			$this->view->add_tag("destination", $this->destination);
			$this->view->add_tag("distance", sprintf("%2.1f km", $distance / 1000));
			$this->view->add_tag("duration", sprintf("%d:%2d", $hours, $minutes));

			foreach ($steps as $step) {
				$this->view->add_tag("step", $step["description"], array(
					"distance" => $step["distance"],
					"duration" => $step["duration"]));
			}

			$this->view->close_tag();
		}
	}
?>
