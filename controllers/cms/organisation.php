<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class cms_organisation_controller extends Banshee\tablemanager_controller {
		protected $name = "Organisation";
		protected $back = "cms";
		protected $icon = "organisations.png";

		public function show_item_form($item) {
			if (valid_input($item["id"], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				if (($users = $this->model->get_users($item["id"])) !== false) {
					$this->view->open_tag("users");
					foreach ($users as $user) {
						$this->view->record($user, "user");
					}
					$this->view->close_tag();
				}
			}

			parent::show_item_form($item);
		}
	}
?>
