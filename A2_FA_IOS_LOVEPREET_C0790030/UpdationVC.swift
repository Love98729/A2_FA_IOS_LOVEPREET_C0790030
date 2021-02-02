

import UIKit
import CoreData

enum Modify {
    case update
    case add
}

class UpdationVC: UIViewController {
    
    @IBOutlet weak var Update: UIButton!
    @IBOutlet weak var txPProvider: UITextField!
    @IBOutlet weak var txPPrice: UITextField!
    @IBOutlet weak var txPdDesc: UITextView!
    @IBOutlet weak var pdNAme: UITextField!
    @IBOutlet weak var PdID: UILabel!
    var prod : Product?
    var modify : Modify = .add
    let previousID = UserDefaults.standard.value(forKey: "LastID") as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product Addition"
        if Modify == .update{
            title = "Product to Edit"
            Update.setTitle("Update", for: .normal)
            PdID = ((prod?.Product)!)
         pdNAme = " prod?.Product ?? "
            txPdDesc.text = prod?.prodDesc ?? ""
            txPProvider.text = prod?.prodProvider ?? ""
            txPPrice.text = "\((prod?.prodPrice)!)"
        }else{
            
        func showAlert(msg:String, title:String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func addUpdateTaped(_ sender: UIButton) {
        if prodNAme.text?.count ?? 0 == 0{
            self.showAlert(msg: "Please enter Product name", title: "Empty field")
            return
        }
        else if txProdDesc.text?.count ?? 0 == 0{
            self.showAlert(msg: "Please enter Product description", title: "Empty field")
            return
        }
        else if txProdPrice.text?.count ?? 0 == 0{
            self.showAlert(msg: "Please enter Product price", title: "Empty field")
            return
        }
        else if txProdProvider.text?.count ?? 0 == 0{
            self.showAlert(msg: "Please enter Product provider", title: "Empty field")
            return
        }
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        if Modify == .update{
            
            prod!.prodName = prodNAme.text ?? ""
            prod!.prodDesc = txProdDesc.text ?? ""
            prod!.prodPrice = Float(txProdPrice.text ?? "0.0") ?? 0.0
            prod!.prodProvider = txProdProvider.text ?? ""
            
            do {
                try viewContext.save()
                print("Saving Done")
                self.navigationController?.popToRootViewController(animated: true)
            }
            catch {
                print("Saving Core Data Failed: \(error)")
            }
        }
        else{
            
            let entity = NSEntityDescription.entity(forEntityName: "Product", in: viewContext)!
            let product = Product(entity: entity, insertInto: viewContext)
            
            product.prodID = Int16(lastID + 1)
            product.prodName = prodNAme.text ?? ""
            product.prodDesc = txProdDesc.text ?? ""
            product.prodPrice = Float(txProdPrice.text ?? "0.0") ?? 0.0
            product.prodProvider = txProdProvider.text ?? ""
            UserDefaults.standard.set(product.prodID, forKey: "LastID")
            do {
                try viewContext.save()
                print("Saving Done")
                self.navigationController?.popToRootViewController(animated: true)
            }
            catch {
                print("Saving Core Data Failed: \(error)")
            }
        }
    }
    
        }
}
}
