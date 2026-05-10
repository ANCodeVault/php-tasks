<?php

declare(strict_types=1);

namespace App\patterns\structural;

use App\patterns\structural\Decorator\V1\DoubleRoomBooking;
use App\patterns\structural\Decorator\V1\ExtraBed;
use App\patterns\structural\Decorator\V1\WiFi;
use PHPUnit\Framework\TestCase;

class DecoratorTest extends TestCase
{

    public function test_can_calculate_price_for_basic_double_room_booking(): void
    {
        $booking = new DoubleRoomBooking();

        $this->assertSame(40, $booking->calculatePrice());
        $this->assertSame('Double room booking', $booking->getDescription());
    }

    public function test_can_calculate_price_for_double_room_booking_with_wifi(): void
    {
        $booking = new DoubleRoomBooking();
        $booking = new WiFi($booking);

        $this->assertSame(42, $booking->calculatePrice());
        $this->assertSame('Double room booking with wifi', $booking->getDescription());
    }

    public function test_can_calculate_price_for_double_room_booking_with_wifi_and_extra_bed(): void
    {
        $booking = new DoubleRoomBooking();
        $booking = new WiFi($booking);
        $booking = new ExtraBed($booking);

        $this->assertSame(72, $booking->calculatePrice());
        $this->assertSame('Double room booking with wifi with extra bed', $booking->getDescription());
    }

}
