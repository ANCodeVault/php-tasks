<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Command\V1;

interface UndoableCommand extends Command
{

    public function undo(): void;

}
