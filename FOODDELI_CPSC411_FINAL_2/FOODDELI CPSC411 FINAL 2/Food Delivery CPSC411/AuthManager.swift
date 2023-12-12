import SwiftUI

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    
    func login(username: String, password: String) {
        // Implement your login logic here.
        // For demonstration purposes, you can set isLoggedIn to true.
        isLoggedIn = true
    }
    
    func logout() {
        // Implement your logout logic here.
        // For demonstration purposes, you can set isLoggedIn to false.
        isLoggedIn = false
    }
}
