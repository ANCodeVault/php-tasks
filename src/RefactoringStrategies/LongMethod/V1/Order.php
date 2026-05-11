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
        $result = $this->applyDiscount($this->calculateTotalSum());

        return round($result, 2);
    }

    private function calculateTotalSum(): float
    {
        $result = 0;

        foreach ($this->getItems() as $item) {
            $result += $item->calculate($this);
        }

        return $result;
    }

    private function applyDiscount(float $total): float
    {
        if ($this->hasDiscount()) {
            $total = $total - ($total / 100 * $this->getDiscount());
        } elseif ($this->isCustomerDiscount($total)) {
            $total = $total - ($total / 100 * $this->getCustomer()->getDiscountForMaxAmount());
        }

        return $total;
    }

    private function isCustomerDiscount(float $total): bool
    {
        return $this->getCustomer()->hasDiscountForMaxAmount() && $total >= $this->getCustomer()->getMaxAmountForDiscount();
    }

}
