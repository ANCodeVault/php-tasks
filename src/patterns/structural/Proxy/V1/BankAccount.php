<?php

declare(strict_types=1);

namespace App\patterns\structural\Proxy\V1;

interface BankAccount
{

    public function deposit(int $amount): void;

    public function getBalance(): int;

}
