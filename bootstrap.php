<?php

$classes = ["controllers", "models", "components"];

foreach ($classes as $class) {
	foreach (glob("./" . $class . "/*.php") as $file) {
		require_once $file;
	}
}

function renderView($path, $data = null) {
	$templates = new \League\Plates\Engine("./views", "tpl");
	if (isset($data)) {
		echo $templates->render($path, $data);
	} else {
		echo $templates->render($path);
	}
}