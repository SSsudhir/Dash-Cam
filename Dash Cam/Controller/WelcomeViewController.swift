import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var openCameraButton: UIButton!
    @IBOutlet weak var hdrVideoButton: UIButton!
    @IBOutlet weak var autoDimButton: UIButton!
    @IBOutlet weak var cameraSelector: UISegmentedControl!
    @IBOutlet weak var resoutionSelector: UISegmentedControl!
    @IBOutlet weak var dashCamLabel: UIImageView!
    
    @IBAction func openCamera(_ sender: Any) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    var button = RadarAnimation(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        button.center = self.view.center
        view.addSubview(button)
        button.pulse()
        
        hdrVideoButton.clipsToBounds = true
        hdrVideoButton.layer.cornerRadius = 7.5
        
        autoDimButton.clipsToBounds = true
        autoDimButton.layer.cornerRadius = 7.5
        
        cameraSelector.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        resoutionSelector.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
        view.sendSubviewToBack(button)
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
        button.center = self.view.center
        button.pulse()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    

    // Update position of animation when device orientation changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.button.isHidden = true
            self.cameraSelector.isHidden = true
            self.resoutionSelector.isHidden = true
            self.dashCamLabel.isHidden = true
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? true {
                    self.cameraSelector.isHidden = false
                    self.resoutionSelector.isHidden = false
                    self.dashCamLabel.isHidden = false
                }
            
                self.button.center = self.view.center
                self.button.isHidden = false
        })
        super.viewWillTransition(to: size, with: coordinator)

    }
    
    
    @IBAction func hdrVideoPressed(_ sender: Any) {
        if hdrVideoButton.backgroundColor == #colorLiteral(red: 0.6427945495, green: 0, blue: 0.002547488548, alpha: 1) {
            hdrVideoButton.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        } else {
            hdrVideoButton.backgroundColor = #colorLiteral(red: 0.6427945495, green: 0, blue: 0.002547488548, alpha: 1)
        }
    }
    @IBAction func autoDimPressed(_ sender: Any) {
        if autoDimButton.backgroundColor == #colorLiteral(red: 0.6427945495, green: 0, blue: 0.002547488548, alpha: 1) {
            autoDimButton.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        } else {
            autoDimButton.backgroundColor = #colorLiteral(red: 0.6427945495, green: 0, blue: 0.002547488548, alpha: 1)
        }
    }
    @IBAction func cameraSelectorToggle(_ sender: Any) {
    }
    @IBAction func resolutionSelectorToggle(_ sender: Any) {
    }
}

extension UISegmentedControl {

    func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.foregroundColor] = color
        self.setTitleTextAttributes(attributes, for: state)
    }
    
    func setTitleFont(_ font: UIFont, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: state) ?? [:]
        attributes[.font] = font
        self.setTitleTextAttributes(attributes, for: state)
    }

}
