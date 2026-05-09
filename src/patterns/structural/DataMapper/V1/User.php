<?php

declare(strict_types=1);

namespace App\patterns\structural\DataMapper\V1;

readonly class User
{

    public function __construct(
        private string $username,
        private string $email,
    ) {}

    public static function fromState(array $state): User
    {
        return new User(
            $state['username'],
            $state['email'],
        );
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function getEmail(): string
    {
        return $this->email;
    }

}
