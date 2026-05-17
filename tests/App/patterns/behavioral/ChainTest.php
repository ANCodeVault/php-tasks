<?php

declare(strict_types=1);

namespace App\patterns\behavioral;

use App\patterns\behavioral\ChainResponsibilities\V1\Handler;
use App\patterns\behavioral\ChainResponsibilities\V1\HttpInMemoryCacheHandler;
use App\patterns\behavioral\ChainResponsibilities\V1\RequestInterface;
use App\patterns\behavioral\ChainResponsibilities\V1\SlowDatabaseHandler;
use App\patterns\behavioral\ChainResponsibilities\V1\UriInterface;
use PHPUnit\Framework\TestCase;

class ChainTest extends TestCase
{

    private Handler $chain;

    public function setUp(): void
    {
        $this->chain = new HttpInMemoryCacheHandler(
            ['/foo/bar?index=1' => 'Hello in Memory'],
            new SlowDatabaseHandler(),
        );
    }

    public function test_can_request_key_in_fast_storage(): void
    {
        $uri = $this->createMock(UriInterface::class);
        $uri->method('getPath')->willReturn('/foo/bar');
        $uri->method('getQuery')->willReturn('index=1');

        $request = $this->createMock(RequestInterface::class);
        $request->method('getMethod')->willReturn('GET');
        $request->method('getUri')->willReturn($uri);

        $this->assertSame('Hello in Memory', $this->chain->handle($request));
    }

    public function testCanRequestKeyInSlowStorage()
    {
        $uri = $this->createMock(UriInterface::class);
        $uri->method('getPath')->willReturn('/foo/baz');
        $uri->method('getQuery')->willReturn('');

        $request = $this->createMock(RequestInterface::class);
        $request->method('getMethod')
            ->willReturn('GET');
        $request->method('getUri')->willReturn($uri);

        $this->assertSame('Hello world', $this->chain->handle($request));
    }

}
