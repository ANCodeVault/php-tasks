<?php

declare(strict_types=1);

namespace App\Refactoring\LongMethod\V1;

use App\RefactoringStrategies\LongMethod\V1\Customer;
use App\RefactoringStrategies\LongMethod\V1\Order;
use App\RefactoringStrategies\LongMethod\V1\OrderDetail;
use PHPUnit\Framework\TestCase;

class OrderTest extends TestCase
{

    public function test_add_order_details_to_orders(): void
    {
        // Arrange
        $order = new Order(Customer::create('Username', 'Address', 0, 1000, 0));
        $order->addItems($this->items());

        // Act
        $result = $order->getItems();

        // Assert
        $this->assertCount(2, $result);
    }

    public function test_calculate_total_sum_orders(): void
    {
        $order = new Order(Customer::create('Username', 'Address', 0, 1000, 0));
        $order->addItems($this->items());

        $result = $order->calculate();

        $this->assertSame(1300.0, $result);
    }

    public function test_calculate_total_sum_orders_with_discount(): void
    {
        $order = new Order(Customer::create('Username', 'Address', 0, 1000, 10));
        $order->addItems($this->items());

        $result = $order->calculate();

        $this->assertSame(1170.0, $result);
    }

    public function test_calculate_total_sum_orders_with_discount_and_vat(): void
    {
        $order = new Order(Customer::create('Username', 'Address', 10, 1000, 5));
        $order->addItems($this->items());

        $result = $order->calculate();

        $this->assertSame(1358.5, $result);
    }

    private function items(): array
    {
        return [
            new OrderDetail(500, 2, 0),
            new OrderDetail(300, 1, 0),
        ];
    }

}
