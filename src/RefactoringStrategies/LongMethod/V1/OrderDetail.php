<?php

declare(strict_types=1);

namespace App\RefactoringStrategies\LongMethod\V1;

class OrderDetail
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

    public function getVat(): int
    {
        return $this->vat;
    }

    public function hasVat(): bool
    {
        return $this->vat > 0;
    }

}
