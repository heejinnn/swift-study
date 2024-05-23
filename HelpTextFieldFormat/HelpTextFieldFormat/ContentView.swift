

import SwiftUI

struct ContentView: View {
    
    @State var text = ""
    
    var body: some View {
        VStack {
            TextField("" ,text: $text)
                .border(Color.black)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
