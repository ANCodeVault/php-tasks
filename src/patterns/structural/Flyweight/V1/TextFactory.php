<?php

declare(strict_types=1);

namespace App\patterns\structural\Flyweight\V1;

use Countable;

class TextFactory implements Countable
{

    private array $charPool = [];

    public function get(string $name): Text
    {
        if (!isset($this->charPool[$name])) {
            $this->charPool[$name] = $this->create($name);
        }

        return $this->charPool[$name];
    }

    private function create(string $name): Text
    {
        $len = strlen($name);

        return match(true) {
            $len === 1 => new Character($name),
            default => new Word($name),
        };
    }

    public function count(): int
    {
        return count($this->charPool);
    }

}
