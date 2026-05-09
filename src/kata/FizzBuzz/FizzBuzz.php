<?php

declare(strict_types=1);

namespace App\kata\FizzBuzz;

use InvalidArgumentException;

class FizzBuzz
{

    public const int TRIGGER_FIZZ = 3;
    public const int TRIGGER_BUZZ = 5;

    public function __invoke(int $number): string
    {
        if (1 > $number || $number > 100) {
            throw new InvalidArgumentException('Number must be between 1 and 100');
        }

        $result = null;

        if ($number % self::TRIGGER_FIZZ === 0) {
            $result .= 'Fizz';
        }

        if ($number % self::TRIGGER_BUZZ === 0) {
            $result .= 'Buzz';
        }

        return $result ?? (string)$number;
    }

}
