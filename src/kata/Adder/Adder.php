<?php

declare(strict_types=1);

namespace App\kata\Adder;

class Adder
{

    public function add($first, $second): int
    {
        return (int) $first + (int) $second;
    }

}
