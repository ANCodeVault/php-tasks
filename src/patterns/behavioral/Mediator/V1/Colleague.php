<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Mediator\V1;

abstract class Colleague
{

    protected Mediator $mediator;

    public function setMediator(Mediator $mediator): void
    {
        $this->mediator = $mediator;
    }

}
