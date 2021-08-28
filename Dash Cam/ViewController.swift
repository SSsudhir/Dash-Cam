import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var openCameraButton: UIButton!
    @IBAction func openCamera(_ sender: Any) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    var button = PulseAnimation(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        button.center = self.view.center
        print(button.center)
        view.addSubview(button)
        button.pulse()
        
        view.bringSubviewToFront(openCameraButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        
        button.center = self.view.center
        button.pulse()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    @objc func viewDidBecomeActive(){
        button.pulse()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    

    // Update position of animation when device orientation changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.button.isHidden = true
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                self.button.center = self.view.center
                self.button.isHidden = false
        })
        super.viewWillTransition(to: size, with: coordinator)

    }
}


