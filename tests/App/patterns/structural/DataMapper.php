<?php

declare(strict_types=1);

namespace App\patterns\structural;

use App\patterns\structural\DataMapper\V1\StorageAdapter;
use App\patterns\structural\DataMapper\V1\User;
use App\patterns\structural\DataMapper\V1\UserMapper;
use InvalidArgumentException;
use PHPUnit\Framework\TestCase;

class DataMapper extends TestCase
{

    public function test_can_map_user_from_storage(): void
    {
        $id = 1;
        $storage = new StorageAdapter([
            1 => ['username' => 'someone', 'email' => 'someone@example.com'],
        ]);
        $mapper = new UserMapper($storage);

        $user = $mapper->findById($id);

        $this->assertInstanceOf(User::class, $user);
    }

    public function test_will_not_map_invalid_data(): void
    {
        $this->expectException(InvalidArgumentException::class);

        $id = 1;
        $storage = new STorageAdapter([]);
        $mapper = new UserMapper($storage);

        $mapper->findById($id);
    }

}
