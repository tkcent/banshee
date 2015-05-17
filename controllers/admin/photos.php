<?php
	class admin_photos_controller extends controller {
		private $back = CMS_DIRECTORY;

		private function show_overview() {
			if (($albums = $this->model->get_albums()) === false) {
				return false;
			}
			if (($photos = $this->model->get_photos($_SESSION["photo_album"])) === false) {
				return false;
			}

			$this->output->open_tag("overview");

			$this->output->open_tag("albums", array("current" => $_SESSION["photo_album"]));
			foreach ($albums as $album) {
				$label = $album["name"].", ".date("d M Y", $album["timestamp"]);
				$this->output->add_tag("album", $label, array("id" => $album["id"]));
			}
			$this->output->close_tag();

			$this->output->open_tag("photos");
			foreach ($photos as $photo) {
				$photo["overview"] = show_boolean($photo["overview"]);
				$this->output->record($photo, "photo");
			}
			$this->output->close_tag();

			$this->output->close_tag();
		}

		private function show_edit_form($photo) {
			$this->output->open_tag("edit");
			$photo["overview"] = show_boolean($photo["overview"]);
			$this->output->record($photo, "photo");
			$this->output->close_tag();
		}

		public function execute() {
			$this->page_size = $this->settings->admin_page_size;

			/* Work-around for the most fucking annoying crap browser in the world: IE
			 */
			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				foreach ($_FILES as $i => $file) {
					if ($file["type"] == "image/pjpeg") {
						$files[$i]["type"] = "image/jpeg";
					}
				}

				if (($_POST["title"] == "") && isset($_POST["photo_album_id"])) {
					if (($count = $this->model->count_photos_in_album($_POST["photo_album_id"])) !== false) {
						$_POST["title"] = "Photo ".($count + 1);
					}
				}
			}

			if (isset($_SESSION["photo_album"]) == false) {
				if (($albums = $this->model->get_albums()) != false) {
					$_SESSION["photo_album"] = (int)$albums[0]["id"];
				}
			}

			if (($_SERVER["REQUEST_METHOD"] == "POST") && ($_POST["submit_button"] == "album")) {
			}

			if (($album_count = $this->model->count_albums()) === false) {
				$this->output->add_tag("result", "Error counting albums");
				return;
			} else if ($album_count == 0) {
				$this->output->add_tag("result", "No albums have been created. Click <a href=\"/".CMS_DIRECTORY."/albums\">here</a> to create a new photo album.");
				return;
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				if ($_POST["submit_button"] == "album") {
					/* Select album
					 */
					$_SESSION["photo_album"] = (int)$_POST["album"];
					$this->show_overview();
				} else if ($_POST["submit_button"] == "Upload photos") {
					/* Upload photos
					 */
					if ($this->model->upload_oke($_FILES["photos"]) == false) {
						$this->show_overview();	
					} else if ($this->model->create_photos($_FILES["photos"], $_POST) == false) {
					} else {
						$this->show_overview();
					}
				} else if ($_POST["submit_button"] == "Save photo") {
					/* Save photo
					 */
					if ($this->model->edit_oke($_POST) == false) {
						$this->show_edit_form($_POST);
					} else if ($this->model->update_photo($_POST) == false) {
						$this->show_edit_form($_POST);
					} else {
						$this->show_overview();
					}
				} else if ($_POST["submit_button"] == "Delete photo") {
					/* Delete photo
					 */
					if ($this->model->delete_photo($_POST["id"]) == false) {
						$this->output->add_message("Error while deleting photo.");
						$this->show_edit_form($_POST);
					} else {
						$this->show_overview();
					}
				} else {
					$this->show_overview();
				}
			} else if (valid_input($this->page->pathinfo[2], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				if (($photo = $this->model->get_photo($this->page->pathinfo[2])) != false) {
					$this->show_edit_form($photo);
				} else {
					$this->output->add_tag("result", "Photo not found.");
				}
			} else {
				$this->show_overview();
			}
		}
	}
?>
