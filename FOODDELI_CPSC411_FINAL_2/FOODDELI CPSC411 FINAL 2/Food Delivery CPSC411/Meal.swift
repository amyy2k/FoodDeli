import SwiftUI

struct Meal: View {
    @State private var quantity = 0
    @State var meal : Card
    @State var heart = "heart.fill"
    @State private var price = 0
    @EnvironmentObject var shoppingCart: ShoppingCart
    @State private var showSuccessAlert = false
    var placeHolder = "Nine years earlier, Lorem ipsum dolor sit amet,Morbi sed purus nulla. Curabitur dapibus ultrices lorem vitae tincidunt. Pellentesque quis arcu sit amet urna commodo porttitor. Aenean sit "
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                GeometryReader{reader in
                    Image(meal.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                        .offset(y: -reader.frame(in: .global).minY)
                        .frame(width: UIScreen.main.bounds.width, height: max(reader.frame(in: .global).minY + 300, 300))
                    
                }
                .frame(height: 280)
                
                VStack(alignment: .leading,spacing: 15){
                    
                    Text(meal.title)
                        .font(.system(size: 35, weight: .bold))
                    
                    
                    HStack(spacing: 10){
                        
                        ForEach(1..<5){_ in
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    HStack {
                        Text(meal.descrip)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top,5)
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
                        .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                    
                    
                    Text("Description")
                        .font(.system(size: 25, weight: .bold))
                    
                    Text(placeHolder)
                        .padding(.top, 10)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                    HStack {
                        Text("Quantity ")
                            .font(.title3)
                            .bold()
                        Spacer()

                        HStack {
                            
                            Button(action: {
                                quantity += 1
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                            }

                            Text("\(quantity)")
                                .font(.title2)
                                .bold()
                                .frame(width: 30)

                            Button(action: {
                                if quantity > 0 {
                                    quantity -= 1
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 24))
                            }
                        }
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(10)

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
                    .padding(.top,10)

                    HStack {
                        Text("Total Price ")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text(String(format: "$%.2f", Double(quantity) * meal.price))
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
            })
            
            
            Spacer()
            
            HStack{
                Spacer()
                Button(action: {
                    shoppingCart.addToCart(meal: meal, quantity: quantity)
                    showSuccessAlert = true
                }, label: {
                    Text("Add to Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 100)
                        .background(Color.red)
                        .cornerRadius(10)
                    
                })
                
                .alert(isPresented: $showSuccessAlert){
                        Alert(title: Text("Item Added"),
                              message: Text("\(meal.title) has been added to your cart."),
                              dismissButton: .default(Text("OK")))
                    }
                Spacer()
            }
            .padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            .edgesIgnoringSafeArea(.all)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
    
}



struct Meal_Previews: PreviewProvider {
    static var previews: some View {
        Meal(meal: TrendingCard[0])
    }
}
