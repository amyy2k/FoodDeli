import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    @State private var isNavigatingToSignUp = false
    @State private var isNavigatingToMainPage = false
    @State private var isLoggedIn = false // Track login status
    
    @State private var showError = false // Track if error should be shown
    
    let titleColor = Color(red: Double(0x12) / 255.0, green: Double(0x66) / 255.0, blue: Double(0x78) / 255.5)

    
    var body: some View {
        NavigationStack {
            VStack {
                Text("FoodDeli")
                    .font(.system(size: 65, weight: .heavy))
                    .fontWeight(.bold)
                    .foregroundColor(titleColor)
                    .padding()
                
                Image("moto")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100)
                
                Text("WELCOME")
                    .font(.system(size: 60, weight: .heavy))
                    .padding(.vertical, 10)
                
                Text("Say hello to FoodDeli. A food order app that helps users find their perfect meal match by applying filters and criteria")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .padding(.horizontal, 55)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .padding(.horizontal, 55)
                    .padding(.top, 10)
                
                NavigationLink(destination: MainPageView(), isActive: $isNavigatingToMainPage) {
                    EmptyView()
                }
                .opacity(0) // Hide the actual link view
                
                Button(action: {
                    // Check if username and password are filled
                    if !username.isEmpty && !password.isEmpty {
                        // Implement your login logic here
                        // For demonstration, we assume login is successful
                        isLoggedIn = true
                        isNavigatingToMainPage = true
                    } else {
                        // Show an error message
                        showError = true
                    }
                }) {
                    Text("LOGIN")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .cornerRadius(5)
                        .padding(.horizontal, 155)
                        .padding(.top, 10)
                }
                .disabled(isLoggedIn)
                
                Spacer()
                
                HStack {
                    Text("Not a Member? Click here to")
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                    }label: {
                        HStack {
                            Text("SIGN UP")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                            
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in both username and password fields."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // Check if the user is already logged in
            if isLoggedIn {
                // Automatically navigate to the main page
                isNavigatingToMainPage = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
