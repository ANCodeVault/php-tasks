<?php

declare(strict_types=1);

namespace App\kata\PrimeNumbers;

class PrimeFactor
{

    public function generate(int $number): array
    {
        $factors = [];

        for ($divisor = 2; $number > 1; $divisor++) {
            for (; $number % $divisor === 0; $number /= $divisor) {
                $factors[] = $divisor;
            }
        }

        return $factors;
    }

}
