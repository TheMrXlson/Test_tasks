import Foundation

protocol Coffee {
    var cost: Int { get }
}

class SimpleCoffie: Coffee {
    var cost: Int = 100
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class Milk: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        base.cost + 50
    }
}

class Sugar: CoffeeDecorator {
    var base: Coffee
    
    required init(base: Coffee) {
        self.base = base
    }
    
    var cost: Int {
        base.cost + 20
    }
}

let coffee = SimpleCoffie()
let milkCoffee = Milk(base: coffee)

print(coffee.cost)
print(milkCoffee.cost)
