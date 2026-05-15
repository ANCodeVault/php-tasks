<?php

declare(strict_types=1);

namespace App\patterns\structural\Proxy\V1;

class HeavyBankAccount implements BankAccount
{

    private array $transactions = [];

    public function deposit(int $amount): void
    {
        $this->transactions[] = $amount;
    }

    public function getBalance(): int
    {
        return array_sum($this->transactions);
    }

}
