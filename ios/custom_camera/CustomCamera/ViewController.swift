import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    //MARK: - Outlets
    @IBOutlet weak var cameraButton: UIButton!
    
    //MARK: - Properties
    var captureSession = AVCaptureSession()
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
    
    var image: UIImage?
    
    var hasTurnedCamera: Bool = false
    

    //MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        captureSession.startRunning()
        styleCaptureButton()
    }

    //MARK: - Setup functions
    func setupCaptureSession() {
        self.captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }

    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                                      mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                self.backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                self.frontCamera = device
            }
        }
        self.currentDevice = self.backCamera
    }

    func setupInputOutput() {
        do {
            
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            self.captureSession.addInput(captureDeviceInput)
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            self.captureSession.addOutput(photoOutput!)
            
        } catch {
            print(error)
        }
    }

    func setupPreviewLayer() {
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.cameraPreviewLayer?.frame = view.frame
        self.view.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)
    }
    
    //MARK: - Setup styles
    func styleCaptureButton() {
        self.cameraButton.layer.borderColor = UIColor.white.cgColor
        self.cameraButton.layer.borderWidth = 5
        self.cameraButton.clipsToBounds = true
        self.cameraButton.layer.cornerRadius = min(cameraButton.frame.width, cameraButton.frame.height) / 2
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Preview_Segue" {
            let previewViewController = segue.destination as! PreviewViewController
            previewViewController.image = self.image
        }
    }

    //MARK: - Actions
    @IBAction func cameraButton_TouchUpInside(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    @IBAction func turnButton_TouchUpInside(_ sender: Any) {
        do {
            let currentInput = self.captureSession.inputs[0]
            self.captureSession.removeInput(currentInput)
            
            if (hasTurnedCamera) {
                self.currentDevice = self.backCamera
            } else {
                self.currentDevice = self.frontCamera
            }
            
            self.hasTurnedCamera = !self.hasTurnedCamera
            
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            self.captureSession.addInput(captureDeviceInput)
            
        } catch {
            print(error)
        }
    }
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer) {
        guard let device = self.currentDevice else { return }
        
        
    }
    
    //MARK: - Capture Photo Delegate
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            self.image = UIImage(data: imageData)
            performSegue(withIdentifier: "Preview_Segue", sender: nil)
        }
    }
}

