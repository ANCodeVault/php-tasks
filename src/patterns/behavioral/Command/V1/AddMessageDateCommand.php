<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Command\V1;

readonly class AddMessageDateCommand implements UndoableCommand
{

    public function __construct(private Receiver $output) {}

    public function execute(): void
    {
        $this->output->enableDate();
    }

    public function undo(): void
    {
        $this->output->disableDate();
    }

}
