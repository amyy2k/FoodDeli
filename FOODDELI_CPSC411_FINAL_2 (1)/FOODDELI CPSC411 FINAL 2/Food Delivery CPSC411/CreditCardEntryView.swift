struct CreditCardEntryView: View {
    @Binding var cardNumber: String
    @Binding var expirationDate: String
    @Binding var cvv: String

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
                // Add logic to validate and handle credit card information
            }
            .padding()
        }
        .padding()
    }
}
