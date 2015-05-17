<?php
	class admin_photos_model extends model {
		protected $table = "photos";
		protected $order = "title";
		protected $extensions = array(
			"image/gif"  => "gif",
			"image/jpeg" => "jpg",
			"image/png"  => "png");

		public function count_albums() {
			$query = "select count(*) as count from photo_albums";

			if (($result = $this->db->execute($query)) == false) {
				return false;
			}

			return $result[0]["count"];
		}

		public function count_photos_in_album($album_id) {
			$query = "select count(*) as count from photos where photo_album_id=%d";
			if (($result = $this->db->execute($query, $album_id)) == false) {
				return false;
			}

			return $result[0]["count"];
		}

		public function get_albums() {
			$query = "select id,name,UNIX_TIMESTAMP(timestamp) as timestamp from photo_albums order by name";

			return $this->db->execute($query);
		}

		public function get_photo($photo_id) {
			return $this->db->entry("photos", $photo_id);
		}

		public function get_photos($album_id) {
			$query = "select * from photos where photo_album_id=%d order by title";

			return $this->db->execute($query, $album_id);
		}

		public function upload_oke($photos) {
			if ($photos["error"][0] == 4) {
				$this->output->add_message("No photos were uploaded.");
				return false;
			}

			$result = true;

			$allowed_types = array_keys($this->extensions);
			$count = count($photos["name"]);
			for ($i = 0; $i < $count; $i++) {
				if ($photos["error"][$i] != 0) {
					$this->output->add_message("Error while uploading %s.", $photos["name"][$i]);
					$result = false;
				} else if (in_array($photos["type"][$i], $allowed_types) == false) {
					$this->output->add_message("Incorrect file type for %s.", $photos["name"][$i]);
					$result = false;
				}
			}

			return $result;
		}

		public function edit_oke($photo) {
			$result = true;

			if (trim($photo["title"]) == "") {
				$this->output->add_message("Enter a title.");
				$result = false;
			}

			return $result;
		}

		private function save_image($photo) {
			switch ($photo["extension"]) {
				case "gif": $image = new gif_image(); break;
				case "jpg": $image = new jpeg_image(); break;
				case "png": $image = new png_image(); break;
				default: return false;
			}

			$image->load($photo["file"]);

			if (($image->width > $this->settings->photo_image_height) || ($image->height > $this->settings->photo_image_width)) {
				$image->resize($this->settings->photo_image_height, $this->settings->photo_image_width);
			}

			if ($image->save(PHOTO_PATH."/image_".$photo["id"].".".$photo["extension"]) == false) {
				return false;
			}
			unset($image);

			return true;
		}

		private function save_thumbnail($photo) {
			switch ($photo["extension"]) {
				case "gif": $image = new gif_image(); break;
				case "jpg": $image = new jpeg_image(); break;
				case "png": $image = new png_image();	break;
				default: return false;
			}

			$image->load($photo["file"]);
			$image->resize($this->settings->photo_thumbnail_height, $this->settings->photo_thumbnail_width);

			if ($image->save(PHOTO_PATH."/thumbnail_".$photo["id"].".".$photo["extension"]) == false) {
				return false;
			}
			unset($image);

			return true;
		}

		private function set_extension(&$item) {
			if (isset($_FILES["image"]) == false) {
				return true;
			} else if ($_FILES["image"]["error"] != 0) {
				return true;
			}

			$type = $_FILES["image"]["type"];
			if (isset($this->extensions[$type]) == false) {
				return false;
			}

			$item["extension"] = $this->extensions[$type];

			return true;
		}

		public function create_photos($photos, $settings) {
			$count = count($photos["name"]);
			$photo_nr = $this->count_photos_in_album($_SESSION["photo_album"]);

			for ($i = 0; $i < $count; $i++) {
				if ($photos["error"][$i] != 0) {
					continue;
				}

				$extension = $this->extensions[$photos["type"][$i]];

				$data = array(
					"id"             => null,
					"title"          => "Photo ".(++$photo_nr),
					"photo_album_id" => $_SESSION["photo_album"],
					"extension"      => $extension,
					"overview"       => is_true($settings["overview"]) ? YES : NO);

				$this->db->query("begin");

				if ($this->db->insert("photos", $data) == false) {
					$this->db->query("rollback");
					continue;
				}

				$photo = array(
					"id"        => $this->db->last_insert_id,
					"file"      => $photos["tmp_name"][$i],
					"extension" => $extension);

				if ($this->save_image($photo) == false) {
					$this->db->query("rollback");
				} else if ($this->save_thumbnail($photo) == false) {
					$this->db->query("rollback");
					unlink(PHOTO_PATH."/image_".$photo["id"].".".$extension);
				} else {
					$this->db->query("commit");
				}
			}

			return true;
		}

		public function update_photo($photo) {
			$data = array(
				"title"    => $photo["title"],
				"overview" => is_true($photo["overview"]) ? YES : NO);

			return $this->db->update("photos", $photo["id"], $data) !== false;
		}

		public function delete_photo($photo_id) {
			if (($photo = $this->get_photo($photo_id)) == false) {
				return false;
			}
			$extension = $photo["extension"];

			if ($this->db->delete("photos", $photo_id) === false) {
				return false;
			}

			$files = array(
				PHOTO_PATH."/image_".$photo_id.".".$extension,
				PHOTO_PATH."/thumbnail_".$photo_id.".".$extension);
			foreach ($files as $file) {
				if (file_exists($file)) {
					unlink($file);
				}
			}

			return true;
		}
	}
?>
