<?php

declare(strict_types=1);

namespace App\patterns\behavioral\ChainResponsibilities\V1;

abstract class Handler
{

    public function __construct(private ?Handler $successor = null) {}

    abstract public function processing(RequestInterface $request): ?string;

    final public function handle(RequestInterface $request): ?string
    {
        $processed = $this->processing($request);

        if ($processed === null && $this->successor !== null) {
            $processed = $this->successor->handle($request);
        }

        return $processed;
    }

}
