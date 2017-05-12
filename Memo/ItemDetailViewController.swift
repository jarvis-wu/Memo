
import UIKit

protocol AddItemDelegate {
    func userDidAddItem(manager: ItemListManager)
}

class ItemDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var itemListManager: ItemListManager!
    
    var currentItemIndex: Int! // used for deleting existing item
    var currentItem: SingleItem? // used for viewing existing item
    
    var delegate: AddItemDelegate? = nil
    let picker = UIImagePickerController()
    
    // * Outlets declaration * //
    
    @IBOutlet weak var itemTitleTextField: UITextField!
    @IBOutlet weak var itemNotesTextView: UITextView!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var deleteItemButton: UIBarButtonItem!
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var uploadImage: UIImageView!
    
    
    @IBAction func titleTextFieldDidChange(_ sender: UITextField) {
        if (itemTitleTextField.text?.isEmpty == false) {
            addItemButton.isEnabled = true
        } else {
            addItemButton.isEnabled = false
        }
    } // automatically disable save button if title is empty
    
    @IBAction func addPictureButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    // -------------------------- Saving actions definition ----------------------------
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if (currentItemIndex == nil) { // add new item
            let newItem: SingleItem = SingleItem()
            newItem.itemTitle = itemTitleTextField.text!
            newItem.itemNotes = itemNotesTextView.text!
            newItem.editDate = Date()
            itemListManager.addItem(item: newItem)
            delegate!.userDidAddItem(manager: itemListManager)
        } else { // edit old item
            itemListManager.itemList[currentItemIndex].itemTitle = itemTitleTextField.text!
            itemListManager.itemList[currentItemIndex].itemNotes = itemNotesTextView.text!
            itemListManager.itemList[currentItemIndex].editDate = Date()
        }
        self.navigationController!.popViewController(animated: true)
    }
    
    
    // ------------------------ Deleting actions definition -----------------------------
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        itemListManager.deleteItem(index: currentItemIndex)
        self.navigationController!.popViewController(animated: true)
    }
    
    // ----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self // set image picker delegate
        
        //////////////// DISABLED DUE TO TECHNICAL PROBLEM ////////////////////
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
//        uploadImage.addGestureRecognizer(tapGesture)
//        uploadImage.isUserInteractionEnabled = true
        styleTextView()
        if (currentItem != nil) {
            itemTitleTextField!.text = currentItem!.itemTitle
            itemNotesTextView!.text = currentItem!.itemNotes
            updateDateLabel!.text = "Last edited on " + getDateString(currentDate: currentItem!.editDate)
        } else {
            itemTitleTextField!.text = ""
            itemNotesTextView!.text = ""
            updateDateLabel!.text = ""
        }
    }
    
    // * Used to display existed item title and notes * //
    
    func loadExistedItem(item: SingleItem, index: Int) {
        currentItem = item
        currentItemIndex = index
    }
    
    // -----------------------------------------------------------------------------------
    
    // * A helper function that converts data to string * //
    
    private func getDateString(currentDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter.string(from: currentDate)
    }
    
    // * A helper function that styles text view to look like text field * //
    
    private func styleTextView() {
        let borderColor: UIColor = UIColor(colorLiteralRed: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        itemNotesTextView.layer.borderColor = borderColor.cgColor
        itemNotesTextView.layer.borderWidth = 0.5
        itemNotesTextView.layer.cornerRadius = 5.0
        itemNotesTextView.textContainerInset = UIEdgeInsetsMake(6, 3, 6, 3) // adjust text view padding
        
    }
    
    // * A helper function that automatically dismiss keyboard after editing * //
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //////////////// DISABLED DUE TO TECHNICAL PROBLEM ////////////////////
//    @objc private func imageTapped(gesture: UITapGestureRecognizer) {
//        if ((gesture.view as? UIImageView) != nil) {
//            performSegue(withIdentifier: "showImage", sender: self)
//        }
//    }
    
    // * Delegate methods * //
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        uploadImage.contentMode = .scaleAspectFill
        uploadImage.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //////////////// DISABLED DUE TO TECHNICAL PROBLEM ////////////////////
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "showImage") {
//            let showImageViewController: ShowImageViewController = segue.destination as! ShowImageViewController
//            showImageViewController.imageView.image = uploadImage.image
//        }
//    }
    
}
