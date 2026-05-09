<?php

declare(strict_types=1);

namespace App\kata;

use App\kata\Adder\Adder;
use PHPUnit\Framework\TestCase;

class AdderTest extends TestCase
{

    /**
     * @dataProvider validSumProvider
     */
    public function test_valid_sum($a, $b, $expectedResult): void
    {
        $this->assertSame($expectedResult, new Adder()->add($a, $b));
    }

    public function validSumProvider(): array
    {
        return [
            [null, null, 0],
            [0, 0, 0],
            [1, 1, 2],
        ];
    }

}
