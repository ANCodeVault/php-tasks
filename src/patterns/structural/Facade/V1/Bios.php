<?php

declare(strict_types=1);

namespace App\patterns\structural\Facade\V1;

interface Bios
{

    public function execute(): void;

    public function waitForKeyPress(): void;

    public function launch(OperatingSystem $os): void;

    public function powerDown(): void;

}
