
import SwiftUI

struct PostMainView: View {
    
    @StateObject var postData = PostData()
    
    var body: some View {
        NavigationView {
           
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 180))], spacing: 20) {
                    ForEach(postData.data, id: \.0) { content, imageData in
                        VStack {
                            Image(uiImage: imageData!)
                                .resizable()
                                .frame(width: 180, height: 180)
                            
                            Text(content)
                                .frame(width: 180)
                        }
                        .background(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.top, 20)
            .background(Color.gray.opacity(0.3).edgesIgnoringSafeArea(.bottom))
            .navigationBarTitle(Text("PostMain"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    NavigationLink(destination: PostInputView(data: $postData.data)) {
                Image(systemName: "plus")
                    .imageScale(.large)
            }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostMainView()
    }
}
