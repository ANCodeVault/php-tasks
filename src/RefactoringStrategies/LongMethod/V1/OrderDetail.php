<?php

declare(strict_types=1);

namespace App\RefactoringStrategies\LongMethod\V1;

class OrderDetail
{

    private int $price;
    private int $quantity;
    private int $vat;

    public function __construct(
        int $price,
        int $quantity,
        int $vat,
    ) {
        $this->price = $price;
        $this->quantity = $quantity;
        $this->vat = $vat;
    }

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
