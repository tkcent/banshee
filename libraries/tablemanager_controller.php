<?php
	/* libraries/tablemanager_controller.php
	 *
	 * Copyright (C) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * http://www.banshee-php.org/
	 */

	namespace Banshee;

	abstract class tablemanager_controller extends controller {
		protected $name = "Table";
		protected $pathinfo_offset = 1;
		protected $back = null;
		protected $icon = null;
		protected $page_size = 25;
		protected $pagination_links = 7;
		protected $pagination_step = 7;
		protected $foreign_null = "---";
		protected $log_column = null;
		protected $browsing = "pagination";
		protected $enable_search = false;
		private   $_table_class = "table table-striped table-hover table-condensed";

		/* Show overview
		 *
		 * INPUT:  array( string key => string value[, ...] )
		 * OUTPUT: -
		 * ERROR:  -
		 */
		protected function show_overview() {
			switch ($this->browsing) {
				case "alphabetize":
					$alphabet = new alphabetize($this->view, "tableadmin_".$this->model->table);
					if ($_POST["submit_button"] == "Search") {
						$alphabet->reset();
					}

					if (($items = $this->model->get_items($alphabet->char)) === false) {
						$this->view->add_tag("result", "Error while creating overview.");
						return;
					}
					break;
				case "pagination":
					if (($item_count = $this->model->count_items()) === false) {
						$this->view->add_tag("result", "Error while counting items.");
						return;
					}

					$paging = new pagination($this->view, "tableadmin_".$this->model->table, $this->page_size, $item_count);
					if ($_POST["submit_button"] == "Search") {
						$paging->reset();
					}

					if (($items = $this->model->get_items($paging->offset, $paging->size)) === false) {
						$this->view->add_tag("result", "Error while creating overview.");
						return;
					}
					break;
				case "datatables":
					$this->view->add_javascript("jquery/jquery.js");
					$this->view->add_javascript("banshee/jquery.datatables.js");
					$this->view->run_javascript("$(document).ready(function(){ $('table.datatable').dataTable(); });");
					$this->view->add_css("banshee/datatables.css");
					$this->_table_class = "datatable";
					$this->enable_search = false;
				default:
					if (($items = $this->model->get_items()) === false) {
						$this->view->add_tag("result", "Error while creating overview.");
						return;
					}
			}

			if ($this->table_class != null) {
				$this->_table_class .= " ".$this->table_class;
			}

			$params = array(
				"class"        => $this->_table_class,
				"allow_create" => show_boolean($this->model->allow_create));
			$this->view->open_tag("overview", $params);

			/* Labels
			 */
			$this->view->open_tag("labels", array("name" => strtolower($this->name)));
			foreach ($this->model->elements as $name => $element) {
				$args = array(
					"name"     => $name,
					"overview" => show_boolean($element["overview"]));
				if ($element["overview"]) {
					$this->view->add_tag("label", $element["label"], $args);
				}
			}
			$this->view->close_tag();

			/* Values
			 */
			$this->view->open_tag("items");
			foreach ($items as $item) {
				$this->view->open_tag("item", array("id" => $item["id"]));
				foreach ($item as $name => $value) {
					$element = $this->model->elements[$name];
					if ($element["overview"]) {
						switch ($element["type"]) {
							case "boolean":
								$value = show_boolean($value);
								break;
							case "date":
								$value = date("j F Y", strtotime($value));
								break;
							case "timestamp":
								$value = date("j F Y H:i", strtotime($value));
								break;
							case "checkbox":
								$checkboxes = json_decode($value);
								$value = array();
								if (is_array($checkboxes)) {
									foreach ($checkboxes as $checkbox) {
										if (($result = $this->db->entry($element["table"], $checkbox)) != false) {
											if (is_array($element["column"]) == false) {
												$value[] = $result[$element["column"]];
											} else {
												$values = array();
												foreach ($element["column"] as $column) {
													array_push($values, $result[$column]);
												}
												$value[] = implode(" ", $values);
											}
										}
									}
								}
								$value = implode(", ", $value);
								break;
							case "foreignkey":
								if ($value === null) {
									$value = $this->foreign_null;
								} else if (($result = $this->db->entry($element["table"], $value)) != false) {
									if (is_array($element["column"]) == false) {
										$value = $result[$element["column"]];
									} else {
										$values = array();
										foreach ($element["column"] as $column) {
											array_push($values, $result[$column]);
										}
										$value = implode(" ", $values);
									}
								}
								break;
						}
						$this->view->add_tag("value", $value, array("name" => $name));
					}
				}
				$this->view->close_tag();
			}
			$this->view->close_tag();

			switch ($this->browsing) {
				case "alphabetize":
					$alphabet->show_browse_links();
					break;
				case "pagination":
					$paging->show_browse_links($this->pagination_links, $this->pagination_step);
					break;
			}

			if ($this->enable_search) {
				$this->view->add_tag("search", $_SESSION["tablemanager_search_".$this->model->table]);
			}

			$this->view->close_tag();
		}

		/* Show create / update form
		 *
		 * INPUT:  array( string key => string value[, ...] )
		 * OUTPUT: -
		 * ERROR:  -
		 */
		protected function show_item_form($item) {
			$args = array(
				"name"         => strtolower($this->name),
				"allow_delete" => show_boolean($this->model->allow_delete));

			if (isset($item["id"]) == false) {
				if ($this->model->allow_create == false) {
					$this->show_overview();
					return;
				}
			} else {
				$args["id"] = $item["id"];
				if ($this->model->allow_update == false) {
					$this->show_overview();
					return;
				}
			}

			$this->view->open_tag("edit");

			$this->view->open_tag("form", $args);
			foreach ($this->model->elements as $name => $element) {
				if (($name == "id") || $element["readonly"]) {
					continue;
				}

				$this->view->open_tag("element", array(
					"name" => $name,
					"type" => $element["type"]));

				if (isset($element["label"])) {
					$this->view->add_tag("label", $element["label"]);
				}

				if ($element["type"] == "boolean") {
					$item[$name] = show_boolean($item[$name]);
				} else if ($element["type"] == "timestamp") {
					$item[$name] = date("Y-m-d H:i", strtotime($item[$name]));
				}

				if ($element["type"] != "blob") {
					$this->view->add_tag("value", $item[$name]);
				}

				if ($element["type"] == "checkbox") {
					$element["options"] = array();
					if (is_array($element["column"]) == false) {
						$cols = array($element["column"]);
					} else {
						$cols = $element["column"];
					}
					$qcols = implode(",", array_fill(1, count($cols), "%S"));

					$query = "select id,".$qcols." from %S order by id";
					if (($options = $this->db->execute($query, $cols, $element["table"])) != false) {
						foreach ($options as $option) {
							$values = array();
							foreach ($cols as $col) {
								array_push($values, $option[$col]);
							}
							$element["options"][$option["id"]] = implode(" ", $values);
						}
					}
				}

				if ($element["type"] == "foreignkey") {
					$element["options"] = array();
					if ($element["required"] == false) {
						$element["options"][null] = $this->foreign_null;
					}
					if (is_array($element["column"]) == false) {
						$cols = array($element["column"]);
					} else {
						$cols = $element["column"];
					}
					$qcols = implode(",", array_fill(1, count($cols), "%S"));

					$query = "select id,".$qcols." from %S order by ".$qcols;
					if (($options = $this->db->execute($query, $cols, $element["table"], $cols)) != false) {
						foreach ($options as $option) {
							$values = array();
							foreach ($cols as $col) {
								array_push($values, $option[$col]);
							}
							$element["options"][$option["id"]] = implode(" ", $values);
						}
					}
				}

				switch ($element["type"]) {
					case "date":
						$this->view->add_javascript("jquery/jquery-ui.js");
						$this->view->add_javascript("banshee/datepicker.js");
						$this->view->add_css("jquery/jquery-ui.css");
						break;
					case "timestamp":
						$this->view->add_javascript("jquery/jquery-ui.js");
						$this->view->add_javascript("banshee/jquery.timepicker.js");
						$this->view->add_javascript("banshee/datetimepicker.js");
						$this->view->add_css("jquery/jquery-ui.css");
						$this->view->add_css("banshee/timepicker.css");
						break;
					case "ckeditor":
						$this->view->add_ckeditor("div.btn-group");
						break;
				}

				if ($element["type"] == "checkbox") {
					$checked = array();
					if (is_array($item[$name]) && !empty($item[$name])) {
						foreach ($item[$name] as $key => $value) {
							$checked[] = $value;
						}
					}
					$this->view->open_tag("options");
					foreach ($element["options"] as $value => $label) {
						$vars = array("value" => $value, "name" => $name);
						if (in_array($value, $checked)) {
							$vars["checked"] = "yes";
						}
						$this->view->add_tag("option", $label, $vars);
					}
					$this->view->close_tag();
				}

				if (($element["type"] == "enum") || ($element["type"] == "foreignkey")) {
					$this->view->open_tag("options");
					foreach ($element["options"] as $value => $label) {
						$this->view->add_tag("option", $label, array("value" => $value));
					}
					$this->view->close_tag();
				}

				$this->view->close_tag();
			}
			$this->view->close_tag();

			$this->view->close_tag();
		}

		/* Handle user submit
		 *
		 * INPUT:  -
		 * OUTPUT: -
		 * ERROR:  -
		 */
		protected function handle_submit() {
			$item = strtolower($this->name);

			if ($_POST["submit_button"] == "Save ".$item) {
				/* Add file upload to $_POST
				 */
				foreach ($this->model->elements as $name => $element) {
					if (($element["type"] == "blob") && isset($_FILES[$name])) {
						if ($_FILES[$name]["error"] == 0) {
							$_POST[$name] = file_get_contents($_FILES[$name]["tmp_name"]);
						}
					}
				}

				/* Save item
				 */
				if ($this->model->save_oke($_POST) == false) {
					$this->show_item_form($_POST);
				} else if (isset($_POST["id"]) == false) {
					/* Create item
					 */
					if ($this->model->create_item($_POST) === false) {
						$this->view->add_message("Error while creating ".$item.".");
						$this->show_item_form($_POST);
					} else {
						$name = $this->db->last_insert_id;
						if ($this->log_column != null) {
							$name .= ":".$_POST[$this->log_column];
						}
						$this->user->log_action("%s %S created", strtolower($this->name), $name);

						$this->show_overview();
					}
				} else {
					/* Update item
					 */
					if ($this->model->update_item($_POST) === false) {
						$this->view->add_message("Error while updating ".$item.".");
						$this->show_item_form($_POST);
					} else {
						$name = $_POST["id"];
						if ($this->log_column != null) {
							$name .= ":".$_POST[$this->log_column];
						}
						$this->user->log_action("%s %s updated", strtolower($this->name), $name);

						$this->show_overview();
					}
				}
			} else if ($_POST["submit_button"] == "Delete ".$item) {
				/* Delete item
				 */
				if ($this->model->delete_oke($_POST["id"]) == false) {
					$this->show_item_form($_POST);
				} else if ($this->model->delete_item($_POST["id"]) === false) {
					$this->view->add_message("Error while deleting ".$item.".");
					$this->show_item_form($_POST);
				} else {
					$name = $_POST["id"];
					if ($this->log_column != null) {
						if (($item = $this->model->get_item($_POST["id"])) != false) {
							$name .= ":".$item[$this->log_column];
						}
					}
					$this->user->log_action("%s %s deleted", strtolower($this->name), $name);

					$this->show_overview();
				}
			} else if ($_POST["submit_button"] == "Search") {
				/* Search item
				 */
				$_SESSION["tablemanager_search_".$this->model->table] = $_POST["search"];
				if ($_POST["search"] != "") {
					$this->browsing = null;
				}
				$this->show_overview();
			} else {
				$this->show_overview();
			}
		}

		/* Main function
		 *
		 * INPUT:  -
		 * OUTPUT: true
		 * ERROR:  false
		 */
		public function execute() {
			$this->view->title = $this->name." administration";

			if (is_a($this->model, "Banshee\\tablemanager_model") == false) {
				print "Tablemanager model has not been defined.\n";
				return false;
			}

			/* Check class settings
			 */
			if ($this->model->class_settings_oke() == false) {
				return false;
			}

			/* Start
			 */
			$this->view->add_css("banshee/tablemanager.css");

			$this->view->open_tag("tablemanager");

			$this->view->add_tag("name", $this->name);
			if ($this->back !== null) {
				$this->view->add_tag("back", $this->back);
			}
			if ($this->icon !== null) {
				$this->view->add_tag("icon", $this->icon);
			}

			if ($_SERVER["REQUEST_METHOD"] == "POST") {
				/* Handle forum submit
				 */
				$this->handle_submit();
			} else if ($this->page->pathinfo[$this->pathinfo_offset] == "new") {
				/* Show form for new item
				 */
				$item = array();
				foreach ($this->model->elements as $name => $element) {
					if (isset($element["default"])) {
						$item[$name] = $element["default"];
					} else if ($element["type"] == "date") {
						$item[$name] = date("Y-m-d");
					} else if ($element["type"] == "timestamp") {
						$item[$name] = date("Y-m-d H:i");
					}
				}
				$this->show_item_form($item);
			} else if (valid_input($this->page->pathinfo[$this->pathinfo_offset], VALIDATE_NUMBERS, VALIDATE_NONEMPTY)) {
				/* Show form for existing item
				 */
				if (($item = $this->model->get_item($this->page->pathinfo[$this->pathinfo_offset])) == false) {
					$this->view->add_tag("result", $this->name." not found.");
				} else {
					foreach($this->model->elements as $element) {
						if ($element["type"] == "checkbox") {
							$item[$element["table"]] = json_decode($item[$element["table"]]);
						}
					}
					$this->show_item_form($item);
				}
			} else {
				/* Show item overview
				 */
				if (count($_GET) == 0) {
					$_SESSION["tablemanager_search_".$this->model->table] = null;
				}
				$this->show_overview();
			}

			$this->view->close_tag();

			return true;
		}
	}
?>
