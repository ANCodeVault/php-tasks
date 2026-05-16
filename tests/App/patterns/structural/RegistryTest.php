<?php

declare(strict_types=1);

namespace App\patterns\structural;

use InvalidArgumentException;
use App\patterns\structural\Registry\V1\Registry;
use App\patterns\structural\Registry\V1\Service;
use PHPUnit\Framework\TestCase;

class RegistryTest extends TestCase
{

    private Service $service;

    protected function setUp(): void
    {
        $this->service = $this->getMockBuilder(Service::class)->getMock();
    }

    public function test_set_and_get_logger(): void
    {
        Registry::set(Registry::LOGGER, $this->service);

        $this->assertSame($this->service, Registry::get(Registry::LOGGER));
    }

    public function test_throws_exception_when_invalid_key(): void
    {
        $this->expectException(InvalidArgumentException::class);

        Registry::set('foobar', $this->service);
    }

    /**
     * Обратите внимание на аннотацию @runInSeparateProcess: без неё предыдущий тест мог бы уже установить её, и
     * тестирование было бы невозможно. Именно поэтому следует реализовать внедрение зависимостей, где
     * внедренный класс может быть легко заменен макетом.
     *
     * @runInSeparateProcess
     */
    public function test_throws_exception_when_truing_to_get_not_set_key(): void
    {
        $this->expectException(InvalidArgumentException::class);

        Registry::get(Registry::LOGGER);
    }

}
