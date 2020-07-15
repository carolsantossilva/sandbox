

import UIKit

class PreviewViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var photo: UIImageView!
    
    //MARK: - Properties
    var image:UIImage?
    
    //MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = image
        // Do any additional setup after loading the view.
    }

    //MARK: - Actions
    @IBAction func saveBtn_TouchUpInside(_ sender: Any) {
        guard let imageToSave = image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtn_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
