import SwiftUI

struct Meal: View {
    @State private var quantity = 0
    @State private var stepperValue = 0 // Separate variable to track the stepper value
    @State var meal: Card
    @State var heart = "heart.fill"
    @State private var showAddSuccessMessage = false
    @EnvironmentObject var cart: ShoppingCart
    @Environment(\.presentationMode) var presentationMode

    var totalPrice: Double {
        meal.price * Double(quantity)
    }

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                GeometryReader { reader in
                    Image(meal.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -reader.frame(in: .global).minY)
                        .frame(width: UIScreen.main.bounds.width, height: max(reader.frame(in: .global).minY + 300, 300))
                }
                .frame(height: 280)

                VStack(alignment: .leading, spacing: 15) {
                    Text(meal.title)
                        .font(.system(size: 35, weight: .bold))

                    HStack(spacing: 10) {
                        ForEach(1..<5) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }

                    HStack {
                        Text(meal.descript)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                        Spacer()

                        Button(action: {
                            withAnimation(.spring(dampingFraction: 0.5)) {
                                heart = "heart"
                            }
                        }, label: {
                            Image(systemName: heart)
                                .font(.largeTitle)
                                .foregroundColor(.red)
                        })
                        .padding(.all, 10)
                    }

                    HStack {
                        Text("Quantity ")
                            .font(.title3)
                            .bold()
                        Spacer()

                        // Stepper with quantity display
                        Stepper("", onIncrement: {
                            stepperValue += 1
                            quantity = stepperValue // Update quantity when stepper changes
                        }, onDecrement: {
                            if stepperValue > 0 {
                                stepperValue -= 1
                                quantity = stepperValue // Update quantity when stepper changes
                            }
                        })
                        .foregroundColor(.black)
                        .background(Color.white)
                        .frame(width: 100)

                        // Display the quantity next to the plus button
                        Text("\(quantity)")
                            .foregroundColor(.black)
                            .font(.title3)
                    }
                    .padding(.top, 10)

                    HStack {
                        Text("Price ")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text("$\(meal.price, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                    }
                    .padding(.top, 10)

                    HStack {
                        Text("Total Price ")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text("$\(totalPrice, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                    }
                    .padding(.top, 10)
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: -35)
            }

            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    if quantity > 0 {
                        cart.addToCart(meal: meal, quantity: quantity)
                        showAddSuccessMessage = false
//                        quantity = 0
//                        stepperValue = 0 // Reset stepper value
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    } else {
                        showAddSuccessMessage = true
                    }
                }, label: {
                    Text("Add to Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 100)
                        .background(Color.red)
                        .cornerRadius(10)
                })
                Spacer()
            }
            .padding(.all, 10)
            .edgesIgnoringSafeArea(.all)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .alert(isPresented: $showAddSuccessMessage) {
            if quantity > 0 {
                return Alert(
                    title: Text("Added to Cart"),
                    message: Text("Item has been added to your cart."),
                    dismissButton: .default(Text("OK"))
                )
            } else {
                return Alert(
                    title: Text("Quantity is Empty"),
                    message: Text("Please select a quantity greater than 0."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct Meal_Previews: PreviewProvider {
    static var previews: some View {
        Meal(meal: TrendingCard[0])
            .environmentObject(ShoppingCart())
    }
}
