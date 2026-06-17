<?php

declare(strict_types=1);

namespace App\patterns\behavioral\Memento\V1;

use InvalidArgumentException;

class State
{

    public const string STATE_CREATED = 'created';
    public const string STATE_OPENED = 'opened';
    public const string STATE_ASSIGNED = 'assigned';
    public const string STATE_CLOSED = 'closed';

    private string $state;

    private static array $validStates = [
        self::STATE_CREATED,
        self::STATE_OPENED,
        self::STATE_ASSIGNED,
        self::STATE_CLOSED,
    ];

    public function __construct(string $state)
    {
        self::ensureValidState($state);

        $this->state = $state;
    }

    private static function ensureValidState(string $state): void
    {
        if (!in_array($state, self::$validStates)) {
            throw new InvalidArgumentException('Invalid state given');
        }
    }

    public function __toString(): string
    {
        return $this->state;
    }

}
