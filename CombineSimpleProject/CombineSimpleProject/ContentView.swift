

import SwiftUI
import Combine

struct ContentView: View {
    
    var viewModel = CombineViewModel()
    @State var anyCancellable = Set<AnyCancellable>()
    @State var cnt = 0
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("\(cnt)")
            
            Button(action: {
                
                viewModel.cnt.value += 1
                
            }, label: {
                Text("Button")
                    .font(.title)
            })
            
            Button(action: {
                viewModel.cnt.value = 0
            }, label: {
                Text("Reset")
                    .foregroundColor(.red)
            })
            
        }
        .padding()
        .onAppear{
            viewModel.cnt.sink{ value in
                DispatchQueue.main.async {
                    self.cnt = value
                }
                
            }.store(in: &anyCancellable)
        }
    }
}

#Preview {
    ContentView()
}
