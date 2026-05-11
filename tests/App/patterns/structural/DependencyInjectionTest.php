<?php

declare(strict_types=1);

namespace App\patterns\structural;

use App\patterns\structural\DI\V1\DatabaseConfiguration;
use App\patterns\structural\DI\V1\DatabaseConnection;
use PHPUnit\Framework\TestCase;

class DependencyInjectionTest extends TestCase
{

    public function test_dependency_injection(): void
    {
        $config = new DatabaseConfiguration('localhost', 3306, 'user', '12345');
        $connection = new DatabaseConnection($config);

        $this->assertSame('user:12345@localhost:3306', $connection->getDsn());
    }

}
