<?php

declare(strict_types=1);

namespace App\patterns\structural;

use App\patterns\structural\Proxy\V1\BankAccountProxy;
use PHPUnit\Framework\TestCase;

class ProxyTest extends TestCase
{

    public function test_proxy_will_only_execute_expensive_get_balance_once(): void
    {
        $bankAccount = new BankAccountProxy();
        $bankAccount->deposit(30);

        // В этот раз производится расчет баланса
        $this->assertSame(30, $bankAccount->getBalance());

        // Наследование позволяет BankAccountProxy вести себя по отношению к внешнему объекту точно так же, как ServerBankAccount
        $bankAccount->deposit(50);

        // На этот раз возвращается ранее рассчитанный баланс без повторного расчета.
        $this->assertSame(30, $bankAccount->getBalance());
    }

}
