<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Mediator\V1;

class Ui extends Colleague
{

    public function outputUserInfo(string $username): void
    {
        echo $this->mediator->getUser($username);
    }

}
