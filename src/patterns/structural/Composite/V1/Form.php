<?php

declare(strict_types=1);

namespace App\patterns\structural\Composite\V1;

class Form implements Renderable
{

    private array $elements;

    public function addElement(Renderable $element): void
    {
        $this->elements[] = $element;
    }

    public function render(): string
    {
        $formCode = '<form>';

        foreach ($this->elements as $element) {
            $formCode .= $element->render();
        }

        return $formCode . '</form>';
    }

}