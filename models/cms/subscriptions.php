<?php
	class cms_subscriptions_model extends Banshee\tablemanager_model {
		protected $table = "subscriptions";
		protected $order = "email";
		protected $elements = array(
			"email" => array(
				"label"    => "E-mail address",
				"type"     => "varchar",
				"overview" => true,
				"required" => true));
	}
?>
