<?php

declare(strict_types=1);

namespace App\patterns\structural\FluentInterface\V1;

use Stringable;

class Sql implements Stringable
{

    private array $fields = [];
    private array $from = [];
    private array $where = [];

    public function select(array $fields): Sql
    {
        $this->fields = $fields;

        return $this;
    }

    public function from(string $table, string $alias): Sql
    {
        $this->from[] = $table . ' as ' . $alias;

        return $this;
    }

    public function where(string $conditions): Sql
    {
        $this->where[] = $conditions;

        return $this;
    }

    public function __toString(): string
    {
        return sprintf(
            'select %s from %s where %s',
            implode(', ', $this->fields),
            implode(', ', $this->from),
            implode(' and ', $this->where)
        );
    }

}
