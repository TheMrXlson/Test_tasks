import Foundation


struct Product {
    let id: String; // unique identifier
    let name: String;
    let producer: String;
}

protocol Shop {
    /**
     Adds a new product object to the Shop.
     - Parameter product: product to add to the Shop
     - Returns: false if the product with same id already exists in the Shop, true – otherwise.
     */
    func addNewProduct(product: Product) -> Bool
    
    /**
     Deletes the product with the specified id from the Shop.
     - Returns: true if the product with same id existed in the Shop, false – otherwise.
     */
    func deleteProduct(id: String) -> Bool
    
    /**
     - Returns: 10 product names containing the specified string.
     If there are several products with the same name, producer's name is added to product's name in the format "<producer> - <product>",
     otherwise returns simply "<product>".
     */
    func listProductsByName(searchString: String) -> Set<String>
    
    /**
     - Returns: 10 product names whose producer contains the specified string,
     result is ordered by producers.
     */
    func listProductsByProducer(searchString: String) -> [String]
}

// TODO: your implementation goes here
class ShopImpl: Shop {
    
    var allProduct = [Product]()
    
    func addNewProduct(product: Product) -> Bool {
        
        for character in allProduct { // Проверяю на наличие товара по идентичному ID
            if character.id == product.id {
                return false
            }
        }
        allProduct.append(product)
        return true
    }
    
    func deleteProduct(id: String) -> Bool {
        
        for index in 0..<allProduct.count {
            if allProduct[index].id == id { // перебор массива и нахождение товара по нужному ID, удаление этого товара
                allProduct.remove(at: index)
                return true
            }
        }
        return false
    }
    
    func listProductsByName(searchString: String) -> Set<String> {
        var result = Set<String>()
        var amount: Int = 0
        
        
        for character in allProduct {
            if result.count == 10 { // ограничение по количеству на результат
                return result
            } else if character.name.contains(searchString) { // в случае если слово есть в необходимом элементе всех продуктов
                
                for char in allProduct { // проверка на количество идентичных наименований во всем массиве товаров
                    if char.name == character.name {
                        amount += 1
                    }
                }
                
                if amount > 1 {
                    result.insert("\(character.producer) - \(character.name)") // в случае если товары с таким же названием еще будут
                } else {
                    result.insert(character.name) // если наименование товара в единичном экземпляре
                }
                amount = 0
            }
        }
        return result
    }
    
    func listProductsByProducer(searchString: String) -> [String] {
        
        let filtered = allProduct.filter { $0.producer.contains(searchString) } // фильтрация массива по нужному наименованию продюсера
        let sorted = filtered.sorted { $0.id < $1.id } // сортировка по порядку ID
        var result: [String] = []
        
        for character in sorted {
            if result.count == 10 {
                return result
            }
            result.append(character.name)
        }
        
        return result
    }
}

func test(lib: Shop) {
    assert(!lib.deleteProduct(id: "1"))
    assert(lib.addNewProduct(product: Product(id: "1", name: "1", producer: "Lex")))
    assert(!lib.addNewProduct(product: Product(id: "1", name: "any name because we check id only", producer: "any producer")))
    assert(lib.deleteProduct(id: "1"))
    assert(lib.addNewProduct(product: Product(id: "3", name: "Some Product3", producer: "Some Producer2")))
    assert(lib.addNewProduct(product: Product(id: "4", name: "Some Product1", producer: "Some Producer3")))
    assert(lib.addNewProduct(product: Product(id: "2", name: "Some Product2", producer: "Some Producer2")))
    assert(lib.addNewProduct(product: Product(id: "1", name: "Some Product1", producer: "Some Producer1")))
    assert(lib.addNewProduct(product: Product(id: "5", name: "Other Product5", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "6", name: "Other Product6", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "7", name: "Other Product7", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "8", name: "Other Product8", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "9", name: "Other Product9", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "10", name: "Other Product10", producer: "Other Producer4")))
    assert(lib.addNewProduct(product: Product(id: "11", name: "Other Product11", producer: "Other Producer4")))
    
    var byNames: Set<String> = lib.listProductsByName(searchString: "Product")
    assert(byNames.count == 10)
    
    byNames = lib.listProductsByName(searchString: "Some Product")
    assert(byNames.count == 4)
    assert(byNames.contains("Some Producer3 - Some Product1"))
    assert(byNames.contains("Some Product2"))
    assert(byNames.contains("Some Product3"))
    assert(!byNames.contains("Some Product1"))
    assert(byNames.contains("Some Producer1 - Some Product1"))
    
    var byProducer: [String] = lib.listProductsByProducer(searchString: "Producer")
    assert(byProducer.count == 10)

    byProducer = lib.listProductsByProducer(searchString: "Some Producer")
    assert(byProducer.count == 4)
    assert(byProducer[0] == "Some Product1")
    assert(byProducer[1] == "Some Product2" || byProducer[1] == "Some Product3")
    assert(byProducer[2] == "Some Product2" || byProducer[2] == "Some Product3")
    assert(byProducer[3] == "Some Product1")
}

test(lib: ShopImpl())
