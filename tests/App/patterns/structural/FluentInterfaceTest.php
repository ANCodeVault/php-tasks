<?php

declare(strict_types=1);

namespace App\patterns\structural;

use App\patterns\structural\FluentInterface\V1\Sql;
use PHPUnit\Framework\TestCase;

class FluentInterfaceTest extends TestCase
{

    public function test_can_build_sql_query(): void
    {
        $query = (string) new Sql()
            ->select(['foo', 'bar'])
            ->from('foobar', 'f')
            ->where('f.bar = ?');
        $expected = 'select foo, bar from foobar as f where f.bar = ?';

        $this->assertSame($expected, $query);
    }

}
