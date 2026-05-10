<?php

declare(strict_types=1);

namespace App\patterns\structural\Decorator\V1;

class WiFi extends BookingDecorator
{

    private const int PRICE = 2;

    public function calculatePrice(): int
    {
        return $this->booking->calculatePrice() + self::PRICE;
    }

    public function getDescription(): string
    {
        return $this->booking->getDescription() . ' with wifi';
    }

}
