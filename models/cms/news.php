<?php
	class cms_news_model extends tablemanager_model {
		protected $table = "news";
		protected $order = "timestamp";
		protected $elements = array(
			"title" => array(
				"label"    => "Title",
				"type"     => "varchar",
				"overview" => true,
				"required" => true),
			"content" => array(
				"label"    => "Content",
				"type"     => "ckeditor",
				"required" => true),
			"timestamp" => array(
				"label"    => "Timestamp",
				"type"     => "date",
				"overview" => true,
				"readonly" => true));

		public function create_item($item) {
			$item["date"] = date("Y-m-d H:i:s");
			parent::create_item($item);
		}
	}
?>
