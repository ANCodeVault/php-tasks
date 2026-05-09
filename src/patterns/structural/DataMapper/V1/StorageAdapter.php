<?php

declare(strict_types=1);

namespace App\patterns\structural\DataMapper\V1;

class StorageAdapter
{

    public function __construct(private array $data) {}

    public function find(int $id): ?array
    {
        if (!isset($this->data[$id])) {
            return null;
        }

        return $this->data[$id];
    }

}
