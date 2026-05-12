<?php

declare(strict_types=1);

namespace App\patterns\structural\Facade\V1;

class Facade
{

    public function __construct(
        private readonly Bios            $bios,
        private readonly OperatingSystem $os,
    ) {}

    public function turnOn(): void
    {
        $this->bios->execute();
        $this->bios->waitForKeyPress();
        $this->bios->launch($this->os);
    }

    public function turnOff(): void
    {
        $this->os->halt();
        $this->bios->powerDown();
    }

}
