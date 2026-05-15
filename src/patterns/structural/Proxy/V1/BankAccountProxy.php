<?php

declare(strict_types=1);

namespace App\patterns\structural\Proxy\V1;

class BankAccountProxy extends HeavyBankAccount implements BankAccount
{

    private ?int $balance = null;

    public function getBalance(): int
    {
        if ($this->balance === null) {
            $this->balance = parent::getBalance();
        }

        return $this->balance;
    }

}
