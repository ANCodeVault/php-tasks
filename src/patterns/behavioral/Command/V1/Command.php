<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Command\V1;

interface Command
{

    public function execute(): void;

}
