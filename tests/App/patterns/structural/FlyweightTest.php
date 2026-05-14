<?php

declare(strict_types=1);

namespace App\patterns\structural;

use App\patterns\structural\Flyweight\V1\TextFactory;
use PHPUnit\Framework\TestCase;

class FlyweightTest extends TestCase
{

    private array $characters = [
        'a', 'b', 'c', 'd', 'e', 'f', 'g',
        'h', 'i', 'j', 'k', 'l', 'm', 'n',
        'o', 'p', 'q', 'r', 's', 't', 'u',
        'v', 'w', 'x', 'y', 'z',
    ];

    private array $fonts = [
        'Arial',
        'Times New Roman',
        'Verdana',
        'Helvetica',
    ];

    public function test_flyweight(): void
    {
        $factory = new TextFactory();

        for ($i = 0; $i <= 10; $i++) {
            foreach ($this->characters as $char) {
                foreach ($this->fonts as $font) {
                    $flyweight = $factory->get($char);
                    $rendered = $flyweight->render($font);

                    $this->assertSame(sprintf('Character %s with font %s', $char, $font), $rendered);
                }
            }
        }
    }

}
