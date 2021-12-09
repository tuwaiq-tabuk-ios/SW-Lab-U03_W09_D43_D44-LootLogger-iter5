import UIKit

class ChangeDateViewController: UIViewController {
  
  @IBOutlet var datePicker: UIDatePicker!
  
  var item : Item!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    datePicker.datePickerMode = .date
    datePicker.date = item.dateCreated
  }
  
   
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    item.dateCreated = datePicker.date
  }
}
