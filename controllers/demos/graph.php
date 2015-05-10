<?php
	class demos_graph_controller extends controller {
		public function execute() {
			$graph = new graph($this->output);
			$graph->title = "Demo graph";
			$graph->width = 700;
			$graph->height = 200;

			$nr = 1;
			for ($i = 0; $i < 6.3; $i += 0.1) {
				$graph->add_bar("Bar number: ".($nr++), sprintf("%0.2f", sin($i) + 1.5));
			}

			$graph->to_output();
		}
	}
?>
