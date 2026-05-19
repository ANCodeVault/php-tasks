<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Command\V1;

class Receiver
{

    private bool $enableDate = false;
    private array $output = [];

    public function write(string $str): void
    {
        if ($this->enableDate) {
            $str .= ' [' . date('Y-m-d') . ']';
        }

        $this->output[] = $str;
    }

    public function getOutput(): string
    {
        return implode("\n", $this->output);
    }

    public function enableDate(): void
    {
        $this->enableDate = true;
    }

    public function disableDate(): void
    {
        $this->enableDate = false;
    }

}
