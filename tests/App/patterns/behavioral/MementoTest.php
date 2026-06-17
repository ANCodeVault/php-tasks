<?php

declare(strict_types=1);

namespace App\patterns\behavioral;

use App\patterns\behavioral\Memento\V1\State;
use App\patterns\behavioral\Memento\V1\Ticket;
use PHPUnit\Framework\TestCase;

class MementoTest extends TestCase
{

    public function test_open_ticket_assign_and_set_back_to_open(): void
    {
        $ticket = new Ticket();

        $ticket->open();
        $openedState = $ticket->getState();
        $this->assertSame(State::STATE_OPENED, (string)$ticket->getState());

        $memento = $ticket->saveToMemento();

        $ticket->assign();
        $this->assertSame(State::STATE_ASSIGNED, (string)$ticket->getState());

        $ticket->restoreFromMemento($memento);

        $this->assertSame(State::STATE_OPENED, (string)$ticket->getState());
        $this->assertNotSame($openedState, $ticket->getState());
    }

}
