import Foundation

// Create a struct to represent an item in the cart
struct CartItem: Identifiable {
    let id = UUID()
    let meal: Card
    var quantity: Int
    var total: Double {
        return meal.price * Double(quantity)
    }
}

// Create a shopping cart to manage cart items
class ShoppingCart: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var cartCount: Int = 0

    func addToCart(meal: Card, quantity: Int) {
        if let index = items.firstIndex(where: { $0.meal.id == meal.id }) {
            items[index].quantity += quantity
        } else {
            items.append(CartItem(meal: meal, quantity: quantity))
        }
        cartCount = items.count
    }

    func removeFromCart(item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
        cartCount = items.count
    }
    
    func clearCart() {
        items.removeAll()
        cartCount = items.count
    }
}
