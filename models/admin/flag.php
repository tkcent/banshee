<?php
	class admin_flag_model extends tablemanager_model {
		protected $table = "flags";
		protected $order = array("role_id", "module", "flag");
		protected $elements = array(
			"role_id" => array(
				"label"    => "Role",
				"type"     => "foreignkey",
				"table"    => "roles",
				"column"   => "name",
				"overview" => true,
				"required" => true),
			"module" => array(
				"label"    => "Module",
				"type"     => "enum",
				"options"  => array(),
				"overview" => true,
				"required" => true),
			"flag" => array(
				"label"    => "Flag",
				"type"     => "enum",
				"options"  => array(),
				"overview" => true,
				"required" => true));

		public function __construct() {
			global $module_flags;

			$arguments = func_get_args();
			call_user_func_array(array(parent, "__construct"), $arguments);

			$modules = array_keys($module_flags);
			sort($modules);

			foreach ($modules as $module) {
				$this->elements["module"]["options"][$module] = $module;
			}
		}

		public function get_flags($module) {
			global $module_flags;

			if (isset($module_flags[$module]) == false) {
				return false;
			}

			return $module_flags[$module];
		}

		public function get_item($item_id) {
			if (($item = parent::get_item($item_id)) !== false) {
				if (($flags = $this->get_flags($item["module"])) !== false) {
					foreach ($flags as $flag) {
						$this->elements["flag"]["options"][$flag] = $flag;
					}
				}
			}

			return $item;
		}

		public function save_oke($item) {
			global $module_flags;

			$flags = $module_flags[$item["module"]];
			foreach ($flags as $flag) {
				$this->elements["flag"]["options"][$flag] = $flag;
			}

			$query = "select count(*) as count from flags ".
			         "where role_id=%d and module=%s and flag=%s";

			if (($result = $this->db->execute($query, $item["role_id"], $item["module"], $item["flag"])) == false) {
				return false;
			}
			if ($result[0]["count"] > 0) {
				$this->output->add_message("This combination already exists.");
				return false;
			}

			return parent::save_oke($item);
		}
	}
?>
