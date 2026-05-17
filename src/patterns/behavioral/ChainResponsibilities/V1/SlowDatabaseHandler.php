<?php

declare(strict_types=1);

namespace App\patterns\behavioral\ChainResponsibilities\V1;

class SlowDatabaseHandler extends Handler
{

    public function processing(RequestInterface $request): ?string
    {
        return 'Hello world';
    }

}