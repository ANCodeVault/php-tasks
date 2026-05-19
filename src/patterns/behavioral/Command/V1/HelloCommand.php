<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Command\V1;

class HelloCommand implements Command
{

    public function __construct(private readonly Receiver $output) {}

    public function execute(): void
    {
        $this->output->write('Hello world');
    }

}
