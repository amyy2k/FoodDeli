import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cart: ShoppingCart // Inject the shopping cart
        @State private var isShowingPaymentAlert = false
        @State private var isShowingPaymentSheet = false
        @State private var isShowingCreditCardSheet = false
        @State private var cardNumber = ""
        @State private var expirationDate = ""
        @State private var cvv = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Check if the cart is empty
                if cart.items.isEmpty {
                    // Cart is empty
                    Spacer()
                    Text("Your cart is empty")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    // Cart has items
                    List {
                        ForEach(cart.items) { item in
                            HStack {
                                Text(item.meal.title)
                                    .font(.headline)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    HStack {
                                        Text("Quantity:")
                                            .font(.subheadline)
                                        Text("\(item.quantity)")
                                            .font(.subheadline)
                                    }
                                    HStack {
                                        Text("Price:")
                                            .font(.subheadline)
                                        Text("$\(item.total, specifier: "%.2f")")
                                            .font(.subheadline)
                                    }
                                }
                                Button(action: {
                                    removeItem(item: item)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.system(size: 24))
                                }
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listStyle(PlainListStyle())
                    .frame(maxWidth: .infinity)
                    .padding()

                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Credit Card Information")
                            .font(.title)

                        Button(action: {
                            isShowingCreditCardSheet.toggle()
                        }) {
                            Text("Enter Credit Card")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .sheet(isPresented: $isShowingCreditCardSheet) {
                        // This is the content of the credit card entry sheet
                        CreditCardEntryView(cardNumber: $cardNumber, expirationDate: $expirationDate, cvv: $cvv, isPresented: $isShowingCreditCardSheet)
                    }
                    
                    
                    
                    Spacer()

                    HStack {
                        Text("Total:")
                            .font(.headline)
                        Spacer()
                        Text("$\(calculateTotal(), specifier: "%.2f")")
                            .font(.headline)
                    }
                    .padding(.bottom)

                    Button(action: {
                        isShowingPaymentAlert.toggle()
                    }) {
                        Text("Checkout")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationTitle("Checkout")
            .navigationBarItems(trailing: Button("Clear Cart") {
                cart.clearCart()
            })
        }
        .alert(isPresented: $isShowingPaymentAlert) {
            Alert(
                title: Text("Payment Successful"),
                message: Text("Thank you for your order!"),
                primaryButton: .default(Text("OK")) {
                    cart.clearCart()
                },
                secondaryButton: .cancel()
            )
        }
    }

    func calculateTotal() -> Double {
        return cart.items.reduce(0) { $0 + $1.total }
    }

    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            cart.removeFromCart(item: cart.items[index])
        }
    }
    
    func removeItem(item: CartItem) {
        if item.quantity > 1 {
            cart.items = cart.items.map { cartItem in
                if cartItem.id == item.id {
                    return CartItem(meal: cartItem.meal, quantity: cartItem.quantity - 1)
                } else {
                    return cartItem
                }
            }
        } else {
            cart.removeFromCart(item: item)
        }
    }
}

struct CreditCardEntryView: View {
    @Binding var cardNumber: String
    @Binding var expirationDate: String
    @Binding var cvv: String
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            TextField("Card Number", text: $cardNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Expiration Date (MM/YY)", text: $expirationDate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("CVV", text: $cvv)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Done") {
                isPresented = false
            }
            .padding()
        }
        .padding()
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(ShoppingCart()) // Inject a sample cart for preview
    }
}
