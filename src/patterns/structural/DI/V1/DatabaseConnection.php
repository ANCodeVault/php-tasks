<?php

declare(strict_types=1);

namespace App\patterns\structural\DI\V1;

class DatabaseConnection
{
    public function __construct(private DatabaseConfiguration $configuration) {}

    public function getDsn(): string
    {
        return sprintf(
            '%s:%s@%s:%d',
            $this->configuration->getUsername(),
            $this->configuration->getPassword(),
            $this->configuration->getHost(),
            $this->configuration->getPort(),
        );
    }

}
