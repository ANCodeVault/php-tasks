<?php

declare(strict_types=1);

namespace App\RefactoringStrategies\LongMethod\V1;

readonly class Customer
{

    private string $username;
    private string $address;
    private int $vat;
    private int $maxAmountDiscount;
    private int $discountForMaxAmount;

    public function __construct(
        string $username,
        string $address,
        int $vat,
        int $maxAmountDiscount,
        int $discountForMaxAmount,
    ) {
        $this->username = $username;
        $this->address = $address;
        $this->vat = $vat;
        $this->maxAmountDiscount = $maxAmountDiscount;
        $this->discountForMaxAmount = $discountForMaxAmount;
    }

    public static function create(
        string $username,
        string $address,
        int $vat,
        int $maxAmountDiscount,
        int $discountForMaxAmount,
    ): self
    {
        return new self(
            $username,
            $address,
            $vat,
            $maxAmountDiscount,
            $discountForMaxAmount,
        );
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function getAddress(): string
    {
        return $this->address;
    }

    public function getVat(): int
    {
        return $this->vat;
    }

    public function getMaxAmountForDiscount(): int
    {
        return $this->maxAmountDiscount;
    }

    public function getDiscountForMaxAmount(): int
    {
        return $this->discountForMaxAmount;
    }

    public function hasDiscountForMaxAmount(): bool
    {
        return $this->discountForMaxAmount > 0;
    }

    public function hasVat(): bool
    {
        return $this->vat > 0;
    }

}
