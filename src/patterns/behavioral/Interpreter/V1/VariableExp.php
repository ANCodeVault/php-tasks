<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Interpreter\V1;

use Exception;

class VariableExp extends AbstractExp
{

    public function __construct(private string $name) {}

    /**
     * @throws Exception
     */
    public function interpret(Context $context): bool
    {
        return $context->lookUp($this->name);
    }

    public function getName(): string
    {
        return $this->name;
    }
}