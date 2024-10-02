
import SwiftUI

import SwiftUI

struct PopupView: View {
    @Binding var showingPopup: Bool
    @Binding var userInputText: String
    @Binding var data: [String]
    
    var body: some View {
        ZStack{
            VStack (spacing: 10){
                TextField("Title", text: $userInputText)
                    .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 35)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add", action: {
                    data.append(userInputText)
                    userInputText = ""
                    showingPopup = false
                })
                
                .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: 35)
                .foregroundColor(.white)
                .background(userInputText.isEmpty ? Color.gray : Color.blue)
                .cornerRadius(5)
            }
        }

        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
