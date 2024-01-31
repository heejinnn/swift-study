import SwiftUI

struct RegisteredUserView: View {
    var userData: UserData
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {

            Image(uiImage: userData.profileImage!)
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())

            Text(userData.name)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(.top, 50)
    }
}

