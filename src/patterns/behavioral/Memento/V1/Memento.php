<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Memento\V1;

class Memento
{

    public function __construct(private State $state) {}

    public function getState(): State
    {
        return $this->state;
    }

}
