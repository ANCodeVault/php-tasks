<?php

declare(strict_types=1);

namespace App\patterns\structural\Decorator\V1;

abstract class BookingDecorator implements Booking
{

    public function __construct(protected Booking $booking) {}

}
