<?php

declare(strict_types=1);

namespace App\patterns\structural\Flyweight\V1;

class Character implements Text
{

    public function __construct(private readonly string $name) {}

    public function render(string $extrinsicState): string
    {
        return sprintf('Character %s with font %s', $this->name, $extrinsicState);
    }

}
