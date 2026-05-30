<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Mediator\V1;

interface Mediator
{

    public function getUser(string $username): string;

}
