
import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var userInputText = ""
    @State private var data = ["기본", "기본 2"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Todo List")
                    .font(.title)
                    .bold()
                
                List {
                    ForEach(data, id: \.self) { item in
                        TodoListRow(title: item)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
                .listStyle(.plain)
            }
            
            .padding()
            .navigationBarItems(trailing:
                                    Button(action: {
                showingAlert = true
            }) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
                .alert("Todo List 작성", isPresented: $showingAlert) {
                    TextField("Title", text: $userInputText)
                    Button("Add", action: {
                        data.append(userInputText)
                        userInputText = ""
                        showingAlert = false

                    })
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
