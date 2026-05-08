<?php

declare(strict_types=1);

namespace App\patterns\structural\Composite\V1;

readonly class TextElement implements Renderable
{

    public function __construct(private string $text) {}

    public function render(): string
    {
        return $this->text;
    }

}
