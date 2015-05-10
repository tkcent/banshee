<?php
	/* libraries/graph.php
	 *
	 * Copyright (C) by Hugo Leisink <hugo@leisink.net>
	 * This file is part of the Banshee PHP framework
	 * http://www.banshee-php.org/
	 */

	class graph {
		private static $instances = 0;
		private $graph_id = null;
		private $output = null;
		private $height = 150;
		private $width = 500;
		private $title = null;
		private $bars = array();
		private $maxy_width = 50;

		/* Constructor
		 *
		 * INPUT:  -
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __construct($output) {
			$this->output = $output;
			$this->graph_id = ++self::$instances;
		}

		/* Magic method set
		 *
		 * INPUT:  string key, mixed value
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function __set($key, $value) {
			switch ($key) {
				case "height": $this->height = $value; break;
				case "title": $this->title = $value; break;
				case "width": $this->width = $value; break;
			}
		}

		public function add_bar($x, $y) {
			$this->bars[$x] = $y;
		}

		/* Graph to output
		 *
		 * INPUT:  -
		 * OUTPUT: -
		 * ERROR:  -
		 */
		public function to_output() {
			if (($bar_count = count($this->bars)) == 0) {
				return;
			}

			$max_y = 0;
			foreach ($this->bars as $y) {
				if ($y > $max_y) {
					$max_y = $y;
				}
			}

			$this->output->add_css("banshee/graph.css");
			$this->output->add_javascript("banshee/graph.js");

			$params = array(
				"id"         => $this->graph_id,
				"height"     => $this->height,
				"width"      => $this->width,
				"max_y"      => $max_y,
				"bar_width"  => sprintf("%0.2f", $this->width / $bar_count),
				"maxy_width" => $this->maxy_width);
			$this->output->open_tag("graph", $params);
			if ($this->title !== NULL) {
				$this->output->add_tag("title", $this->title);
			}
			foreach ($this->bars as $x => $y) {
				$bar_y = sprintf("%0.2f", $y * $this->height / $max_y);
				$params = array(
					"label" => $x,
					"value" => $y);
				$this->output->add_tag("bar", $bar_y, $params);
			}
			$this->output->close_tag();
		}
	}
?>
