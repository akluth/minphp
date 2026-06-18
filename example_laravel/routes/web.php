<?php
// routes
$routes = [
    '/' => function() { return app('HomeController')->index(); }
];
