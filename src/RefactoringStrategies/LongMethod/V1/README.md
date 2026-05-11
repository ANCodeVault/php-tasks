
# Refactoring Strategies

**Extract method** - (извлечение метода) \
**Pull up field** -  (подъём поля) \
**Form template method** - (создание шаблонного метода) \
**Substitute algorithm** -  (алгоритм замены)

## Long Method (Длинный метод)

Если вы замечаете, что ваш метод (фунция) становится слишком большим и выполняет много обязанностей, то в этом случае вам нужно подумать о разбиении этого метода на более мелкие методы, так как методы проще поддерживать и проще понять их назначение.

Слишком длинные методы очень сложны в понимании и поддержке.

Наиболее распространённая стратегия рефакторинга такого типа программного обеспечения — это выделение метода. Мы находим участки кода, которые хорошо сочетаются друг с другом, и помещаем их во внешний метод. Один эвристический способ, который мы можем использовать для правильного разделения кода — это следовать комментариям. Поскольку читать длинный код очень сложно, усердные программисты часто комментируют блоки кода, объясняя, что они делают. Здесь, каждый раз, когда мы встречаем комментарий, мы можем:

* Напишите новый метод в том же классе (имя должно отражать то, что делает код)
* Переместите блок кода под комментарием из процедуры в новый метод
* Добавьте комментарий, который объясняет не то, что делает метод, а как он это делает

## Преобразование хаоса в хорошо спроектированный код

Рефакторинг — это самый известный способ сохранить код в порядке и избежать его перехода в хаотичное состояние. В то время как код имеет тенденцию постепенно разрушаться и скатываться к хаосу, рефакторинг — это как раз противоположность: мы активно изменяем внутреннюю структуру нашего программного обеспечения, переводя его из хаоса в более упорядоченный дизайн через серию простых и стабильных шагов.

**Класс Customer**

```php
readonly class Customer
{
    private string $username;
    private string $address;
    private int $vat;
    private int $maxAmountDiscount;
    private int $discountForMaxAmount;

    public function __construct(
        string $username,
        string $address,
        int $vat,
        int $maxAmountDiscount,
        int $discountForMaxAmount,
    ) {
        $this->username = $username;
        $this->address = $address;
        $this->vat = $vat;
        $this->maxAmountDiscount = $maxAmountDiscount;
        $this->discountForMaxAmount = $discountForMaxAmount;
    }

    public static function create(
        string $username,
        string $address,
        int $vat,
        int $maxAmountDiscount,
        int $discountForMaxAmount,
    ): self
    {
        return new self(
            $username,
            $address,
            $vat,
            $maxAmountDiscount,
            $discountForMaxAmount,
        );
    }

    public function getUsername(): string
    {
        return $this->username;
    }

    public function getAddress(): string
    {
        return $this->address;
    }

    public function getVat(): int
    {
        return $this->vat;
    }

    public function getMaxAmountForDiscount(): int
    {
        return $this->maxAmountDiscount;
    }

    public function getDiscountForMaxAmount(): int
    {
        return $this->discountForMaxAmount;
    }

    public function hasDiscountForMaxAmount(): bool
    {
        return $this->discountForMaxAmount > 0;
    }

    public function hasVat(): bool
    {
        return $this->vat > 0;
    }

}
```

**Класс OrderDetail**

```php
class OrderDetail
{
    private int $price;
    private int $quantity;
    private int $vat;

    public function __construct(
        int $price,
        int $quantity,
        int $vat,
    ) {
        $this->price = $price;
        $this->quantity = $quantity;
        $this->vat = $vat;
    }

    public function getPrice(): int
    {
        return $this->price;
    }

    public function getQuantity(): int
    {
        return $this->quantity;
    }

    public function getVat(): int
    {
        return $this->vat;
    }

    public function hasVat(): bool
    {
        return $this->vat !== 0;
    }

}
```

**Класс Order**

Это простой класс, предназначенный для описания и управления заказом.

У нас есть класс Order с методом calculate(), который слишком длинный.

```php
class Order
{

    private int $discount = 0;
    private array $items = [];
    private Customer $customer;

    public function __construct(Customer $customer)
    {
        $this->customer = $customer;
    }

    public function getCustomer(): Customer
    {
        return $this->customer;
    }

    public function addItems(array $items): void
    {
        $this->items = array_merge($this->items, $items);
    }

    public function getItems(): array
    {
        return $this->items;
    }

    public function getDiscount(): int
    {
        return $this->discount;
    }

    public function setDiscount(int $discount): void
    {
        $this->discount = $discount;
    }

    public function hasDiscount(): bool
    {
        return !empty($this->getDiscount());
    }

    public function calculate(): float
    {
        $items = $this->getItems();
        $total = 0;

        foreach ($items as $item) {
            if ($item->hasVat()) {
                $vat = $item->getVat();
            } elseif ($this->getCustomer()->hasVat()) {
                $vat = $this->getCustomer()->getVat();
            } else {
                $vat = 0;
            }

            $price = $item->getPrice() * $item->getQuantity();
            $total += $price + ($price / 100 * $vat);
        }

        if ($this->hasDiscount()) {
            $total = $total - ($total / 100 * $this->getDiscount());
        } elseif ($this->getCustomer()->hasDiscountForMaxAmount() && $total >= $this->getCustomer()->getMaxAmountForDiscount()) {
            $total = $total - ($total / 100 * $this->getCustomer()->getDiscountForMaxAmount());
        }

        return round($total, 2);
    }

}
```

Класс работает корректно, что доказывает следующий тест PHPUnit:

**PHPUnit test**

```php
class OrderTest extends TestCase
{

    public function test_add_order_details_to_orders(): void
    {
        // Arrange
        $order = new Order(Customer::create('Username', 'Address', 0, 1000, 0));
        $order->addItems($this->items());

        // Act
        $result = $order->getItems();

        // Assert
        $this->assertCount(2, $result);
    }

    public function test_calculate_total_sum_orders(): void
    {
        // Arrange
        $order = new Order(Customer::create('Username', 'Address', 0, 1000, 0));
        $order->addItems($this->items());

        // Act
        $result = $order->calculate();

        // Assert
        $this->assertSame(1300.0, $result);
    }

    public function test_calculate_total_sum_orders_with_discount(): void
    {
        // Arrange
        $order = new Order(Customer::create('Username', 'Address', 0, 1000, 10));
        $order->addItems($this->items());

        // Act
        $result = $order->calculate();

        // Assert
        $this->assertSame(1170.0, $result);
    }

    public function test_calculate_total_sum_orders_with_discount_and_vat(): void
    {
        // Arrange
        $order = new Order(Customer::create('Username', 'Address', 10, 1000, 5));
        $order->addItems($this->items());

        // Act
        $result = $order->calculate();

        // Assert
        $this->assertSame(1358.5, $result);
    }

    private function items(): array
    {
        return [
            new OrderDetail(500, 2, 0),
            new OrderDetail(300, 1, 0),
        ];
    }

}
```

Во-первых, мы можем упростить этот метод calculate(), выделив два метода:
* один для расчета подробной общей цены  calculateTotalSum()
* другой, чтобы рассчитать правильную скидку на заказ  applyDiscount($total).

Веделяем в метод расчет общей цены заказа:

```php
private function calculateTotalSum(): float
{
	$total = 0;

	foreach ($this->getItems() as $item) {
		if (!$item->hasVat()) {
			$vat = $this->getCustomer()->getVat();
		} else {
			$vat = $item->getVat();
		}

		$price = $item->getAmount() * $item->getPrice();
		$total += $price + ($price / 100 * $vat);
	}

	return $total;
}
```

Выделяем в метод расчет скидки на заказ:

```php
private function applyDiscount($total): float
{
	if ($this->hasDiscount()) {
		$total = $total - ($total / 100 * $this->getDiscount());
	} elseif ($this->getCustomer()->hasDiscountForMaxAmount() && $total >= $this->getCustomer()->getMaxAmountForDiscount()) {
		$total = $total - ($total / 100 * $this->getCustomer()->getDiscountForMaxAmount());
	}

	return $total;
}
```

Получается такая реализация метода calculate() в классе Order:

```php
public function calculate(): float
{
    return round($this->applyDiscount($this->calculateTotalSum()), 2);
}
```
**Перенос метода расчета суммы заказа**

Если мы внимательно посмотрим на метод calculateTotalSum, можно сделать вывод, что в этом методе используется информация из класса OrderDetail, но не информация класса Order.

Из этого можно сделать вывод, что метод расположен в неправильном объекте.

В большинстве случаев метод должен находиться в классе, данные которого он использует, поэтому данный метод нужно переместить в класс, представляющий сведения о заказе OrderDetail.

Значит мы должны извлечь этот метод (calculateTotalSum) и переместить его в класс OrderDetail.

Для этого мы применим стратегию рефакторинга - Перенос метода (Move Method).

Эту стратегию описал Мартин Фаулер:

> Метод использует функциональность другого класса, отличного от того, в котором он определен.
Значит нужно создать новый метод с аналогичным названием в том классе, данные которого используются. И перенести метод в этот класс, а в классе которому нужны эти данные заменить реализацию простым делегированием, или удалить полностью этот метод.

```php
class OrderDetail
{
    //...
    public function calculateTotalSum(): float
    {
        $total = 0;
    
        foreach ($this->getItems() as $item) {
            if (!$item->hasVat()) {
                $vat = $this->getCustomer()->getVat();
            } else {
                $vat = $item->getVat();
            }
    
            $price = $item->getAmount() * $item->getPrice();
            $total += $price + ($price / 100 * $vat);
        }
    
        return $total;
    }
}
```

После переноса метода calculateTotalSum в класс OrderDetail, из этого метода мы можем выделить два метода:
* первый метод будет отвечать за получения ставки НДС
* второй метод будет отвечать за расчет стоимости заказа

```php
class OrderDetail 
{
    //...
	public function getVat(Order $order): int
	{
		if (!$this->hasVat()) {
			return $order->getCustomer()->getVat();
		}

		return $this->vat;
	}

	public function calculate(Order $order): float
	{
		$price = $this->getAmount() * $this->getPrice();

		return $price + ($price / 100 * $this->getVat($order));
	}
}

class Order
{
    //...
	private function calculateTotalSum(): float
	{
		$result = 0;

		foreach ($this->getItems() as $order) {
			$result += $order->calculate($this);
		}

		return $result;
	}
}
```

**Результат рефакторинга**

**Класс OrderDetail**

```php
class OrderDetail
{
	private int $price;
	private int $quantity;
	private int $vat;

	public function __construct(int $price, int $quantity, int $vat)
	{
		$this->price = $price;
		$this->quantity = $quantity;
		$this->vat = $vat;
	}

	public function getPrice(): int
	{
		return $this->price;
	}

	public function getAmount(): int
	{
		return $this->quantity;
	}

	public function calculate(Order $order): float
	{
		$price = $this->getAmount() * $this->getPrice();

		return $price + ($price / 100 * $this->getVat($order));
	}

	public function hasVat(): bool
	{
		return !empty($this->vat);
	}

	public function getVat(Order $order): int
	{
		return $this->hasVat() ? $this->vat : $order->getCustomer()->getVat();
	}
}
```

**Класс Order**

```php
class Order
{
	private int $discount = 0;
	private array $items = [];
	private Customer $customer;

	public function setCustomer(Customer $customer): void
	{
		$this->customer = $customer;
	}

	public function getCustomer(): Customer
	{
		return $this->customer;
	}

	public function setDiscount(int $discount): void
	{
		$this->discount = $discount;
	}

	public function addOrderItems(OrderDetail $item): void
	{
		$this->items[] = $item;
	}

	public function getItems(): array
	{
		return $this->items;
	}

	public function getDiscount(): int
	{
		return $this->discount;
	}

	public function hasDiscount(): bool
	{
		return !empty($this->getDiscount());
	}

	public function calculate(): float
	{
		return round($this->applyDiscount($this->calculateTotalSum()), 2);
	}

	/**
	 * веделяем в метод расчет общей цены заказа
	 */
	private function calculateTotalSum(): float
	{
		$result = 0;

		foreach ($this->getItems() as $order) {
			$result += $order->calculate($this);
		}

		return $result;
	}

	/**
	 * выделяем в метод расчет скидки на заказ
	 */
	private function applyDiscount($total): float
	{
		if ($this->hasDiscount()) {
			$total = $total - ($total / 100 * $this->getDiscount());
		} elseif ($this->getCustomer()->hasDiscountForMaxAmount() && $total >= $this->getCustomer()->getMaxAmountForDiscount()) {
			$total = $total - ($total / 100 * $this->getCustomer()->getDiscountForMaxAmount());
		}

		return $total;
	}
	
}
```



