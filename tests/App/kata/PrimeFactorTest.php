<?php

declare(strict_types=1);

namespace App\kata;

use App\kata\PrimeNumbers\PrimeFactor;
use PHPUnit\Framework\TestCase;

class PrimeFactorTest extends TestCase
{

    /**
     * @dataProvider factorsProvider
     */
    public function test_it_generate_prime_factors_for_one(int $number, array $expected): void
    {
        $factors = new PrimeFactor();

        $this->assertSame($expected, $factors->generate($number));
    }

    public function factorsProvider(): array
    {
        return [
            [1, []],
            [2, [2]],
            [3, [3]],
            [4, [2,2]],
            [5, [5]],
            [6, [2,3]],
            [8, [2,2,2]],
            [100, [2,2,5,5]],
            [999, [3,3,3,37]],
        ];
    }

}
