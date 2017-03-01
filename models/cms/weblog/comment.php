<?php
	class cms_weblog_comment_model extends Banshee\tablemanager_model {
		protected $table = "weblog_comments";
		protected $order = "id";
		protected $desc_order = true;
		protected $allow_create = false;
		protected $elements = array(
			"weblog_id" => array(
				"label"    => "Weblog",
				"type"     => "foreignkey",
				"table"    => "weblogs",
				"column"   => "title",
				"readonly" => true,
				"overview" => true),
			"author" => array(
				"label"    => "Author",
				"type"     => "varchar",
				"overview" => true,
				"required" => true),
			"content" => array(
				"label"    => "Content",
				"type"     => "text",
				"required" => true),
			"timestamp" => array(
				"label"    => "Timestamp",
				"type"     => "varchar",
				"readonly" => true,
				"overview" => true),
			"ip_address" => array(
				"label"    => "IP address",
				"type"     => "varchar",
				"readonly" => true,
				"overview" => true));
	}
?>
