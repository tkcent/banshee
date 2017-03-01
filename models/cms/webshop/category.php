<?php
	class cms_webshop_category_model extends Banshee\tablemanager_model {
		protected $table = "shop_categories";
		protected $order = "name";
		protected $elements = array(
			"name" => array(
				"label"    => "Name",
				"type"     => "varchar",
				"overview" => true,
				"required" => true));
	}
?>
