<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

	class cms_news_model extends Banshee\tablemanager_model {
		protected $table = "news";
		protected $order = "timestamp";
		protected $elements = array(
			"title" => array(
				"label"    => "Title",
				"type"     => "varchar",
				"overview" => true,
				"required" => true),
			"timestamp" => array(
				"label"    => "Publish at",
				"type"     => "timestamp",
				"overview" => true),
			"content" => array(
				"label"    => "Content",
				"type"     => "ckeditor",
				"required" => true));

		public function create_item($item) {
			$item["timestamp"] = date("Y-m-d H:i:s");
			parent::create_item($item);
		}
	}
?>
