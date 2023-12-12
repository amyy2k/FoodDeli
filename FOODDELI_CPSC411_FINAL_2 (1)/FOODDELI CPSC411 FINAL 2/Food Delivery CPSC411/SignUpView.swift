import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var showError: Bool = false // Track if error should be shown
    @State private var isNavigatingToMainPage: Bool = false // Track navigation to main page
    
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
                
                Text("SIGN UP")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 10)
                
                VStack(spacing: 15) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .padding(.horizontal, 55)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .padding(.horizontal, 55)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .padding(.horizontal, 55)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                        .padding(.horizontal, 55)
                }
                
                NavigationLink(destination: MainPageView(), isActive: $isNavigatingToMainPage) {
                    EmptyView()
                }
                .opacity(0) // Hide the actual link view
                
                Button(action: signUp) {
                    Text("CREATE ACCOUNT")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .cornerRadius(5)
                        .padding(.horizontal, 100)
                        .padding(.top, 20)
                }
                
                Spacer()
                
                HStack {
                    Text("Already a Member? Click here to")
                    NavigationLink {
                        LoginView()
                            .navigationBarBackButtonHidden(true)
                    }label: {
                        HStack {
                            Text("LOGIN")
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all required fields."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func signUp() {
        // Check if all fields are filled and passwords match
        if !username.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword {
            // Implement your sign-up logic here
            print("Sign-up attempt with username: \(username), email: \(email), and password: \(password)")
            
            // After successful sign-up, set isNavigatingToMainPage to true to trigger navigation
            isNavigatingToMainPage = true
        } else {
            // Show an error message
            showError = true
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
        }
    }
}
