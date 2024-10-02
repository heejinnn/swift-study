
import SwiftUI

struct PostMainView: View {
    
    @StateObject var postData = PostData()
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack(alignment: .top, spacing: 10) {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 180, maximum: .infinity))], spacing: 20) {
                        ForEach(postData.data.indices.filter { $0 % 2 == 0 }, id: \.self) { index in
                            let (content, imageData) = postData.data[index]
                            VStack {
                                Image(uiImage: imageData!)
                                    .resizable()
                                    //.aspectRatio(contentMode: .fit)
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 180)
                                
                                Text(content)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 180, maximum: 180))], spacing: 20) {
                        ForEach(postData.data.indices.filter { $0 % 2 != 0 }, id: \.self) { index in
                            let (content, imageData) = postData.data[index]
                            VStack {
                                Image(uiImage: imageData!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 180, maxHeight: 180)
                                
                                Text(content)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.bottom))
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
