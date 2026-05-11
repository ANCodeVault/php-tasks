<?php

declare(strict_types=1);

namespace App\RefactoringStrategies\LongMethod\V1;

class Order
{
    private int $discount = 0;
    private array $items = [];

    public function __construct(private readonly Customer $customer) {}

    public function getCustomer(): Customer
    {
        return $this->customer;
    }

    public function addItems(array $items): void
    {
        $this->items = array_merge($this->items, $items);
    }

    public function getItems(): array
    {
        return $this->items;
    }

    public function getDiscount(): int
    {
        return $this->discount;
    }

    public function setDiscount(int $discount): void
    {
        $this->discount = $discount;
    }

    public function hasDiscount(): bool
    {
        return !empty($this->getDiscount());
    }

    public function calculate(): float
    {
        $total = 0;
        $items = $this->getItems();

        foreach ($items as $item) {
            if ($item->hasVat()) {
                $vat = $item->getVat();
            } elseif ($this->getCustomer()->hasVat()) {
                $vat = $this->getCustomer()->getVat();
            } else {
                $vat = 0;
            }

            $price = $item->getPrice() * $item->getQuantity();
            $total += $price + ($price / 100 * $vat);
        }

        if ($this->hasDiscount()) {
            $total = $total - ($total / 100 * $this->getDiscount());
        } elseif ($this->getCustomer()->hasDiscountForMaxAmount() && $total >= $this->getCustomer()->getMaxAmountForDiscount()) {
            $total = $total - ($total / 100 * $this->getCustomer()->getDiscountForMaxAmount());
        }

        return round($total, 2);
    }

}