<?php

declare(strict_types=1);

namespace App\patterns\structural\Facade\V1;

interface OperatingSystem
{

    public function halt(): void;

    public function getName(): string;

}
