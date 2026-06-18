<?php

class App {
    private array $routes = [];

    public function get(string $path, callable $handler): void {
        $this->routes[$path] = $handler;
    }

    public function run(string $path): void {
        if (isset($this->routes[$path])) {
            echo $this->routes[$path]();
        } else {
            echo "404";
        }
    }
}

function view(string $title, string $body): string {
    return "<h1>" . $title . "</h1><p>" . $body . "</p>";
}

$app = new App();

$app->get("/", function() {
    return view("Home", "Hallo Alex, die VM lebt.");
});

$app->get("/about", function() {
    $name = "MiniSlim";
    return view("About", $name . " läuft auf einer eigenen PHP-VM.");
});

$app->run("/");