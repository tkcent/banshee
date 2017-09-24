<?php
	/* Copyright (c) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * https://www.banshee-php.org/
	 *
	 * Licensed under The MIT License
	 */

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
