<?php

declare(strict_types=1);

namespace App\patterns\structural\Decorator\V1;

interface Booking
{

    public function calculatePrice(): int;

    public function getDescription(): string;

}
