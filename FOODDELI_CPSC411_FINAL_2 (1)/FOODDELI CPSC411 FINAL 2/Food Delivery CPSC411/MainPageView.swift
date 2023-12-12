
import SwiftUI

struct MainPageView: View {
    @State var hero = false
    @State var data = TrendingCard
    @EnvironmentObject var cart: ShoppingCart // Inject the shopping cart
    @State private var showingCart = false
    var allItems: [RestaurantItem]{
        return whatsNew + recents + topRated
    }
    
    
    
    // Returns items that match search criteria
    var filteredItems: [RestaurantItem]{
        return allItems.filter{ item in
            item.name.localizedCaseInsensitiveContains(searchText) || item.description.localizedCaseInsensitiveContains(searchText) || item.tag.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    // Class for Restaurants
    struct RestaurantItem: Identifiable {
        let id = UUID()
        let name: String
        let imageName: String
        let rating: Double
        let description: String
        let tag: String
    }
    
    // Categorize Restaurants in each sectiojn
    
    let whatsNew: [RestaurantItem] = [
        RestaurantItem(name: "IN-N-OUT", imageName: "InNOut-logo", rating: 4, description: "Famous for fast food burgers in California and Southwest.", tag: "burger, american, meat, sandwich, fastfood"),
        RestaurantItem(name: "Phoholic", imageName: "Holic-logo", rating: 5, description: "Taste Vietnamese Culture in Phoholic’s Menu", tag: "vietnamese, pho, soup, vietnam, vegan, tiktok, asian"),
        RestaurantItem(name: "Craft By Smoke & Fire", imageName: "CraftBySmoke&Fire", rating: 4, description: "Welcome to BBQ, Steak, Craft cocktails.", tag: "bbq, meat, texan, southern, american"),
        RestaurantItem(name: "The Vox Kitchen", imageName: "TheVox", rating: 5, description: "Inspired by Chifa culinary fusion of Peruvian and Chinese cuisines.", tag: "Kei, vietnamese, fusion, vegan, authentic, famous, tiktok, asian"),
        RestaurantItem(name: "Fogo de Chão Brazilian Steakhouse", imageName: "BrazilianSteakhouse", rating: 4, description: "Internationally-renowned steakhouse from Brazil.", tag:"steak, meat, brazilian, south america, tiktok"),
    ]
    
    let recents: [RestaurantItem] = [
        RestaurantItem(name: "Akashiro", imageName: "Akashiro", rating: 5, description: "The marriage of Japanese precision and Peruvian vibrancy.", tag:"japan, fusion, peruvian, authentic, vegan, tiktok, gluten free, haram"),
        RestaurantItem(name: "Byward Kitchen & Bar", imageName: "BywardKitchen", rating: 4, description: "A venue that offers homemade, traditional, British food.",tag:"britain, chips, english, breakfast, tiktok, vegan, traditional"),
        RestaurantItem(name: "Blacklock", imageName: "Blacklock", rating: 5, description: "Award-winning steak and chophouse in the heart of Shoreditch.",tag:"steak, meat, american, dinner, tiktok, haram, dining"),
        RestaurantItem(name: "Oc & Lau Restaurant", imageName: "OcLau", rating: 3, description: "Escargot, Shrimps, Fish, Clams, Oysters, Razor Clams",tag:"seafood, vegan, vegetarian, vietnamese, snail, authentic, tiktok, dining"),
        RestaurantItem(name: "Acai Point HB", imageName: "Acai", rating: 5, description: "Acai bowls Pitaya bowls Coconut bowls Fresh Fruits Amazing tops.",tag:"dessert, sweet, cold, vegan, sweet"),
    ]
    
    let topRated: [RestaurantItem] = [
        RestaurantItem(name: "Bosscat Kitchen and Libations", imageName: "BosscatKitchen", rating: 4, description: "Whiskey selection and offering of American comfort food.",tag:"dining, fine dining, wine, date, luxury, tasting menu, vegan, tiktok, haram"),
        RestaurantItem(name: "Benny and Mary's", imageName: "Benny", rating: 4, description: "American Vegan Poke.", tag:"vegan, american, poke, GMO-free, haram, vegetarian, halal"),
        RestaurantItem(name: "Postino Park Place", imageName: "Postino", rating: 5, description: "Food with local ingredients, and a warm, edgy culture .", tag:"local, family, homegrown, fresh, halal, vegan"),
        RestaurantItem(name: "KIN Izakaya by Kei Concepts", imageName: "Kin", rating: 4, description: "Sashimi, charcoal-grilled skewers, hand-crafted cocktails",tag: "ramen, meat, skewers, yakitori, japanese, fusion, asian, vegan"),
        RestaurantItem(name: "Rooster & Rice", imageName: "Rooster", rating: 5, description: "Specialize in khao mun gai, Thai-style poached chicken and rice.", tag:"thai, noodles, rice, vegan, asian, fresh, soup, take out"),
    ]
    
    @State private var searchText = ""
    
    // View Recconmendations
    
    var body: some View {
        NavigationView {
            ScrollView {
                if searchText.isEmpty{
                    VStack(alignment: .leading) {
                        Text("Trending Meals")
                            .bold()
                            .font(.title)
                            .multilineTextAlignment(.trailing)
                            .padding(.leading, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(TrendingCard) { card in
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
                        
                        
                        
                        // What's New Section
                        SectionView(title: "WHAT'S NEW", items: whatsNew)
                        
                        // Recents Section
                        SectionView(title: "RECENTS", items: recents)
                        
                        // Top Rated Section
                        SectionView(title: "TOP RATED", items: topRated)
                        
                    }
                }
                else {
                    SectionView(title: "FILTERED", items: filteredItems)
                }
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.blue)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("FoodDeli")
                        .font(.system(size: 25, weight: .heavy))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CheckoutView()) { // Add a NavigationLink to CartView
                        Image(systemName: "cart")
                            .foregroundColor(.blue)
                            .overlay(
                                Text("\(cart.cartCount)")
                                    .font(Font.system(size: 12).bold())
                                    .padding(5)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .foregroundColor(.white)
                                    .offset(x: 10, y: -10)
                                    .opacity(cart.cartCount == 0 ? 0 : 1)
                            )
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarBackButtonHidden(true)
        }
        .opacity(self.hero ? 0 : 1)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: EmptyView())
    }
}


struct SectionView: View {
    let title: String
    let items: [MainPageView.RestaurantItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items) { item in
                        NavigationLink(
                            destination: RestaurantMenuView(restaurant: item),
                            label: {
                                RestaurantView(item: item)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 1)
                            })
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top)
    }
}

struct RestaurantView: View {
    let item: MainPageView.RestaurantItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(item.imageName)
                .resizable()
                .frame(width: 270, height: 150)
            
            HStack {
                Text(item.name)
                    .bold()
                    .padding(.all, 10)
                Spacer()
            }
            
            HStack {
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            
            HStack {
                let rating = Int(item.rating)
                ForEach(0..<5) { index in
                    Image(systemName: index < rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding(.bottom, 30)
            .padding(.leading, 10)
            .padding(.trailing, 10)
        }
        .frame(width: 250, height: 250)
        .cornerRadius(10)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
            .environmentObject(ShoppingCart())
    }
}
