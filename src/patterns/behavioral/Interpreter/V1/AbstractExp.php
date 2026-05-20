<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Interpreter\V1;

abstract class AbstractExp
{

    abstract public function interpret(Context $context): bool;

}
