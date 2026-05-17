<?php

declare(strict_types=1);

namespace App\patterns\behavioral\ChainResponsibilities\V1;

interface UriInterface
{

    public function getPath(): ?string;

    public function getQuery(): ?string;

}
