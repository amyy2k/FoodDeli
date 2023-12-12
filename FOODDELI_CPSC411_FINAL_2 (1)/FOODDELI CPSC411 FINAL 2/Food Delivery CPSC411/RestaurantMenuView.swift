import SwiftUI

// Define RestaurantMenuView to display the menu for a restaurant
struct RestaurantMenuView: View {
    let restaurant: MainPageView.RestaurantItem
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Display restaurant image and name
                Image(restaurant.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                
                Text(restaurant.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                
                Text(restaurant.description)
                    .font(.title2)
                    .padding(.leading, 20)
                    .padding(.bottom, 40)
                
                // Recommended items section
                Text("MENU")
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                    .padding(.leading, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(MenuCard) { card in
                            NavigationLink(
                                destination: Meal(meal: card),
                                label: {
                                    TrendingWeek(trendingMeal: card)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .shadow(radius: 1)
                                })
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 30)
                    }
                }
            }
        }
    }
}

