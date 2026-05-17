<?php

declare(strict_types=1);

namespace App\patterns\behavioral\ChainResponsibilities\V1;

interface RequestInterface
{

    public function getMethod(): ?string;

    public function getUri(): ?UriInterface;

}
