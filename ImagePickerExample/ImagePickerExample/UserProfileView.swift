
import SwiftUI

struct UserProfileView: View {
    
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var userData: UserData = UserData(name: "", profileImage: nil)
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                Button(action: {
                    imagePickerPresented.toggle()
                }, label: {
                    let image =  userData.profileImage == nil ? Image(systemName: "person.circle.fill") : Image(uiImage: userData.profileImage!)
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                })
                TextField("Enter your username", text: $userData.name)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.top, 50)
            .navigationBarTitle("User Profile", displayMode: .inline)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: Text("Settings")) {
                Button(action: {
                    print(userData)
                }, label: {
                    Text("Sign Up")
                })
            }
            )
            .sheet(isPresented: $imagePickerPresented) {
                ImagePickerView(selectedImage: $userData.profileImage, presentationMode: _presentationMode)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
