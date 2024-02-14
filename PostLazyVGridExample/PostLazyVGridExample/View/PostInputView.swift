import SwiftUI

struct PostInputView: View {
    
    @Binding var data: [(String, UIImage?)]
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var inputText = ""
  
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.3).edgesIgnoringSafeArea(.bottom) // 배경색 적용
            
            VStack(alignment: .center, spacing: 20) {
                Button(action: {
                    imagePickerPresented.toggle()
                }, label: {
                    let image =  selectedImage == nil ? Image(systemName: "person.circle.fill") : Image(uiImage: selectedImage!)
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                })
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $inputText)
                        .frame(width: 250, height: 250)
                        .modifier(BorderViewModifier(width: 1, color: .gray, padding: 10))
                    if inputText.isEmpty {
                        Text("Enter your content")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 13)
                            .padding(.top, 25)
                            .opacity(inputText.isEmpty ? 1 : 0)
                            .frame(height: 30)
                    }
                }
                .background(.white)
                
                Spacer()
            }
            .padding(.top, 50)
        }
        .navigationBarItems(trailing:
                                Button(action: {
            self.data.append((self.inputText, self.selectedImage))
            self.presentationMode.wrappedValue.dismiss()//이전 뷰로 돌아가기
        }) {
            Text("Post")
        }
        )
        .sheet(isPresented: $imagePickerPresented) {
            ImagePickerView(selectedImage: $selectedImage)
        }
    }
}
