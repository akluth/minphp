<?php
// bootstrap
function app($make = null) {
    static $container = null;
    if (!$container) $container = [];
    if ($make == 'HomeController') return new \App\Http\Controllers\HomeController();
    return $container;
}
function view($name, $data) {
    return "<h1>Laravel Example</h1><p>" . $data . "</p>";
}
require __DIR__ . '/../routes/web.php';
