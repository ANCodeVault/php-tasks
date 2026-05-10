<?php

declare(strict_types=1);

namespace App\patterns\structural\Decorator\V1;

class DoubleRoomBooking implements Booking
{

    public function calculatePrice(): int
    {
        return 40;
    }

    public function getDescription(): string
    {
        return 'Double room booking';
    }

}
