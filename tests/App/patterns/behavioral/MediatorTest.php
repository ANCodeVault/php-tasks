<?php

declare(strict_types=1);

namespace App\patterns\behavioral;

use App\patterns\behavioral\Mediator\V1\Ui;
use App\patterns\behavioral\Mediator\V1\UserRepository;
use App\patterns\behavioral\Mediator\V1\UserRepositoryUiMediator;
use PHPUnit\Framework\TestCase;

class MediatorTest extends TestCase
{

    public function test_output_hello_world(): void
    {
        $mediator = new UserRepositoryUiMediator(new UserRepository(), new Ui());

        $this->expectOutputString('User: Dominik');
        $mediator->printInfoAbout('Dominik');
    }

}
