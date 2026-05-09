<?php

declare(strict_types=1);

namespace App\kata;

use PHPUnit\Framework\TestCase;

class KataTest extends TestCase
{

    public function test_dummy(): void
    {
        $kata = new Kata();

        $this->assertInstanceOf(Kata::class, $kata);
        $this->assertTrue(false);
    }

    public function test_not_failing(): void
    {
        $this->assertTrue(true);
    }

}
