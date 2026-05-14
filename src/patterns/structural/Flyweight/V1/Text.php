<?php

declare(strict_types=1);

namespace App\patterns\structural\Flyweight\V1;

interface Text
{

    public function render(string $extrinsicState): string;

}
