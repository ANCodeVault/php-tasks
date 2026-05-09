<?php

declare(strict_types=1);

namespace App\kata;

use InvalidArgumentException;
use App\kata\FizzBuzz\FizzBuzz;
use PHPUnit\Framework\TestCase;

class FizzBuzzTest extends TestCase
{

    public function test_returns_fizz_for_multiples_of_three(): void
    {
        $fizzBuzz = new FizzBuzz();
        $numbers = [3, 6, 9, 12, 18, 21, 24, 27];

        foreach ($numbers as $number) {
            $this->assertSame('Fizz', $fizzBuzz($number));
        }
    }

    public function test_returns_buzz_for_multiples_of_five(): void
    {
        $fizzBuzz = new FizzBuzz();
        $numbers = [5, 10, 20, 25];

        foreach ($numbers as $number) {
            $this->assertSame('Buzz', $fizzBuzz($number));
        }
    }

    public function test_returns_fizz_buzz_for_multiples_of_three_and_five(): void
    {
        $fizzBuzz = new FizzBuzz();
        $numbers = [15, 30];

        foreach ($numbers as $number) {
            $this->assertSame('FizzBuzz', $fizzBuzz($number));
        }
    }

    public function test_returns_number_for_non_multiples(): void
    {
        $fizzBuzz = new FizzBuzz();
        $numbers = range(1, 100);

        foreach ($numbers as $number) {
            if ($number % $fizzBuzz::TRIGGER_FIZZ === 0) {
                continue;
            }

            if ($number % $fizzBuzz::TRIGGER_BUZZ === 0) {
                continue;
            }

            $this->assertSame((string)$number, $fizzBuzz($number));
        }
    }

    /**
     * @dataProvider invalidInputProvider
     */
    public function test_throws_exception_on_invalid_input(int $invalidInput): void
    {
        $this->expectException(InvalidArgumentException::class);

        $fizzBuzz = new FizzBuzz();
        $fizzBuzz($invalidInput);
    }

    private function invalidInputProvider(): array
    {
        return [
            [0],
            [-1],
            [101],
        ];
    }

}
