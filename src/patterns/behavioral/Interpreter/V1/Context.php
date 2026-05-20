<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Interpreter\V1;

use Exception;

class Context
{

    private array $poolVariable;

    /**
     * @throws Exception
     */
    public function lookUp(string $name): bool
    {
        if (!key_exists($name, $this->poolVariable)) {
            throw new Exception('No exist variable: ' . $name);
        }

        return $this->poolVariable[$name];
    }

    public function assign(VariableExp $variable, bool $value): void
    {
        $this->poolVariable[$variable->getName()] = $value;
    }

}
