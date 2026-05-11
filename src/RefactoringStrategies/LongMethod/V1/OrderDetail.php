<?php

declare(strict_types=1);

namespace App\RefactoringStrategies\LongMethod\V1;

readonly class OrderDetail
{
    public function __construct(
        private int $price,
        private int $quantity,
        private int $vat,
    ) {}

    public function getPrice(): int
    {
        return $this->price;
    }

    public function getQuantity(): int
    {
        return $this->quantity;
    }

    public function getVat(Order $order): int
    {
        if (!$this->hasVat()) {
            return $order->getCustomer()->getVat();
        }

        return $this->vat;
    }

    public function hasVat(): bool
    {
        return $this->vat > 0;
    }

    public function calculate(Order $order): float
    {
        $price = $this->getPrice() * $this->getQuantity();

        return $price + ($price / 100 * $this->getVat($order));
    }

}
