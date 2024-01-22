import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var currentTimer: Float = 0.0
    
    private var timer: Timer? = nil

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.currentTimer += 0.1
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        stopTimer()
        currentTimer = 0.0
    }
}
