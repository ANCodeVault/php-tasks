<?php

declare(strict_types=1);

namespace App\patterns\behavioral;

use App\patterns\behavioral\Command\V1\HelloCommand;
use App\patterns\behavioral\Command\V1\Invoker;
use App\patterns\behavioral\Command\V1\Receiver;
use PHPUnit\Framework\TestCase;

class CommandTest extends TestCase
{

    public function test_invocation(): void
    {
        $invoker = new Invoker();
        $receiver = new Receiver();
        $helloCommand = new HelloCommand($receiver);
        $invoker->setCommand($helloCommand);

        $invoker->run();

        $this->assertSame('Hello world', $receiver->getOutput());
    }

}
