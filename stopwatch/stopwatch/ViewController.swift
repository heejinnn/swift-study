
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
   
    var timer : Timer?
    var timerNum: Float = 0.0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playBtn.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        pauseBtn.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
    }
    
    @objc func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            self.timerNum += 0.1
            self.numberLabel.text = "\(self.timerNum)"
        }
    }
    
    @objc func pauseTimer(){
        timer?.invalidate()
    }
    
    @objc func resetTimer(){
        timer?.invalidate()
        self.timerNum = 0.0
        self.numberLabel.text = "\(self.timerNum)"
    }
    
}

