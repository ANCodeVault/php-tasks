<?php

declare(strict_types=1);

namespace App\patterns\structural;

use App\patterns\structural\Facade\V1\Bios;
use App\patterns\structural\Facade\V1\Facade;
use App\patterns\structural\Facade\V1\OperatingSystem;
use PHPUnit\Framework\TestCase;

class FacadeTest extends TestCase
{

    public function test_computerOn(): void
    {
        $os = $this->createMock(OperatingSystem::class);
        $os->method('getName')->will($this->returnValue('Linux'));

        $bios = $this->createMock(Bios::class);
        $bios->method('launch')->with($os);

        $facade = new Facade($bios, $os);
        $facade->turnOn();

        $this->assertSame('Linux', $os->getName());
    }

}
