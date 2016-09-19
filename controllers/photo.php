<?php
	class photo_controller extends controller {
		private $title = "Photos";
        private $extensions = array(
			"gif" => "image/gif",
			"jpg" => "image/jpeg",
			"png" => "image/png");

		private function show_albums() {
			$this->title = "Photo albums";

			if (($count = $this->model->count_albums()) === false) {
				$this->output->add_tag("result", "Database error counting albums");
				return;
			}

			$paging = new pagination($this->output, "photo_albums", $this->settings->photo_page_size, $count);

			if (($albums = $this->model->get_albums($paging->offset, $paging->size)) === false) {
				$this->output->add_tag("result", "Database error retrieving albums");
				return;
			} else if (count($albums) == 0) {
				$this->output->add_tag("result", "No photo albums have been created yet.", array("seconds" => 0));
				return;
			}

			$this->output->open_tag("overview");

			$this->output->open_tag("albums");
			foreach ($albums as $album) {
				$album["timestamp"] = date("j F Y", strtotime($album["timestamp"]));
				$this->output->record($album, "album");
			}
			$this->output->close_tag();

			$paging->show_browse_links();

			$this->output->close_tag();
		}

		private function show_album($album_id) {
			if (($album = $this->model->get_album_info($album_id)) === false) {
				$this->output->add_tag("result", "Database error retrieving album information.");
				return;
			} else if ($album === null) {
				$this->output->add_tag("result", "Photo album not found.");
				return;
			}

			if (($count = $this->model->count_photos_in_album($album_id)) === false) {
				$this->output->add_tag("result", "database error counting albums");
				return;
			}

			$paging = new pagination($this->output, "photo_album_".$album_id, $this->settings->photo_album_size, $count);

			if (($photos = $this->model->get_photo_info($album_id, $paging->offset, $paging->size)) === false) {
				$this->output->add_tag("result", "Database error retrieving photos.");
				return;
			} else if (count($photos) == 0) {
				$this->output->add_tag("result", "Photo album is empty.");
				return;
			}

			$this->title = $album["name"];

			$this->output->open_tag("photos", array(
				"timestamp" => date("j F Y", strtotime($album["timestamp"])),
				"info"      => $album["description"],
				"listed"    => show_boolean($album["listed"])));
			foreach ($photos as $photo) {
				$this->output->record($photo, "photo");
			}
			$paging->show_browse_links();
			$this->output->close_tag();

			$this->output->add_javascript("banshee/jquery.prettyphoto.js");
			$this->output->add_javascript("photo.js");

			$this->output->add_css("banshee/prettyphoto.css");
		}

		private function show_photo($photo) {
			list($name, $extension) = explode(".", $photo, 2);

			if ($this->user->logged_in == false) {
				list(, $photo_id) = explode("_", $name, 2);
				if ($this->model->private_photo($photo_id)) {
					return false;
				}
			}

			if (isset($this->extensions[$extension]) == false) {
				return false;
			} else if (file_exists(PHOTO_PATH."/".$photo) == false) {
				return false;
			}

			header("Content-Type: ".$this->extensions[$extension]);
			readfile(PHOTO_PATH."/".$photo);

			$this->output->disable();

			return true;
		}

		public function execute() {
			if (valid_input($this->page->pathinfo[1], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				$this->show_album($this->page->pathinfo[1]);
			} else if (valid_input($this->page->pathinfo[1], VALIDATE_NONCAPITALS.VALIDATE_NUMBERS."_.", VALIDATE_NONEMPTY)) {
				if ($this->show_photo($this->page->pathinfo[1]) == false) {
					header("Result: 404");
					$this->output->add_tag("result", "This image could not be found.");
				}
			} else {
				$this->show_albums();
			}

			$this->output->add_tag("title", $this->title);
			$this->output->title = $this->title;
		}
	}
?>
