import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = TimerViewModel()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Reset") {
                    viewModel.resetTimer()
                }
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: 20)

            Text(String(format: "%.1f", viewModel.currentTimer))
                .font(.system(size: 90))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 250)

            Spacer()

            HStack(spacing: 0) {
                Button {
                    viewModel.startTimer()
                } label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)

                Button {
                    viewModel.stopTimer()
                } label: {
                    Image(systemName: "pause")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
            }

        }
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
