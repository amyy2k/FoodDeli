import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var isLoggingOut = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Profile Header
                Text("My Profile")
                    .font(.system(size: 35, weight: .heavy))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 10)
                
                VStack(alignment: .center, spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, 50)
                    
                    Text("Your Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Member since January 2023")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 50)
                
                // List of Settings
                List {
                    Section {
                        NavigationLink(destination: Text("Manage Account Destination")) {
                            ProfileRow(iconName: "person.fill", title: "Manage Account")
                        }
                        
                        NavigationLink(destination: Text("Rewards Destination")) {
                            ProfileRow(iconName: "gift.fill", title: "Rewards")
                        }
                        
                        NavigationLink(destination: Text("Subscription Destination")) {
                            ProfileRow(iconName: "creditcard.fill", title: "Subscription")
                        }
                        
                        NavigationLink(destination: Text("Sample Terms and Conditions\n\nThis is a sample text for the Terms and Conditions of our app. Please review our terms carefully.")) {
                            ProfileRow(iconName: "doc.text.fill", title: "Terms and Conditions")
                        }
                        
                        NavigationLink(destination: Text("Sample Privacy Policy\n\nThis is a sample text for the Privacy Policy of our app. We take your privacy seriously. Please review our privacy policy.")) {
                            ProfileRow(iconName: "lock.fill", title: "Privacy Policy")
                        }
                        
                        NavigationLink(destination: Text("Help Destination")) {
                            ProfileRow(iconName: "questionmark.circle.fill", title: "Help")
                        }
                        
                        Button(action: {
                            // Set isLoggingOut to true to trigger the NavigationLink
                            isLoggingOut = true
                        }) {
                            ProfileRow(iconName: "arrow.right.square.fill", title: "Log Out")
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                // NavigationLink to the login page when isLoggingOut is true
                NavigationLink("", destination: LoginView(), isActive: $isLoggingOut)
                    .hidden()
                
                
            }
            .navigationBarTitle("", displayMode: .inline)
            
            
        }
    }
}

struct ProfileRow: View {
    var iconName: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
            Text(title)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(AuthManager()) // Inject the AuthManager for previews
        }
    }
}
