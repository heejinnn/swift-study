
import SwiftUI

struct ContentView: View {
    @State private var showingPopup = false
    @State private var userInputText = ""
    @State private var data = ["기본", "기본 2"]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Todo List")
                        .font(.title)
                        .bold()
                    
                    List {
                        ForEach(data, id: \.self) { item in
                            TodoListRow(title: item)
                        }
                    }
                    .listStyle(.plain)
                }
                .padding()
                
                if showingPopup {
                    Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
                    PopupView(showingPopup: $showingPopup, userInputText: $userInputText, data: $data)
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                showingPopup = true
            }) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
                                
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
