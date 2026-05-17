<?php

declare(strict_types=1);

namespace App\patterns\behavioral\ChainResponsibilities\V1;

class HttpInMemoryCacheHandler extends Handler
{

    public function __construct(
        private readonly array $data,
        ?Handler $successor = null,
    ) {
        parent::__construct($successor);
    }

    public function processing(RequestInterface $request): ?string
    {
        $key = sprintf(
            '%s?%s',
            $request->getUri()->getPath(),
            $request->getUri()->getQuery(),
        );

        if ($request->getMethod() === 'GET' && isset($this->data[$key])) {
            return $this->data[$key];
        }

        return null;
    }

}
