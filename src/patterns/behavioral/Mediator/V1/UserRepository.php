<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Mediator\V1;

class UserRepository extends Colleague
{

    public function getUserName(string $user): string
    {
        return 'User: ' . $user;
    }

}
