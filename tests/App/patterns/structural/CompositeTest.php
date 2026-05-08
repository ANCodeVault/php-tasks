<?php

declare(strict_types=1);

namespace App\patterns\structural;

use App\patterns\structural\Composite\V1\Form;
use App\patterns\structural\Composite\V1\InputElement;
use App\patterns\structural\Composite\V1\TextElement;
use PHPUnit\Framework\TestCase;

class CompositeTest extends TestCase
{

    public function test_render(): void
    {
        $form = new Form();
        $form->addElement(new TextElement('Email:'));
        $form->addElement(new InputElement());
        $embed = new Form();
        $embed->addElement(new TextElement('Password:'));
        $embed->addElement(new InputElement());
        $form->addElement($embed);

        $expected = '<form>Email:<input type="text"><form>Password:<input type="text"></form></form>';

        $this->assertSame($expected, $form->render());
    }


}
