//
//  ViewController.swift
//  A2_FA_IOS_LOVEPREET_C0790030
//
//  Created by user189760 on 2/2/21.
//

import UIKit
import CoreData

enum Mode {
    case update
    case add
}

class Add_Update_ProductVC: UIViewController {
    
    @IBOutlet weak var btnAdd_Update: UIButton!
    @IBOutlet weak var txProdProvider: UITextField!
    @IBOutlet weak var txProdPrice: UITextField!
    @IBOutlet weak var txProdDesc: UITextView!
    @IBOutlet weak var prodNAme: UITextField!
    @IBOutlet weak var lbProdID: UILabel!
    var prod : Product?
    var mode : Mode = .add
    let lastID = UserDefaults.standard.value(forKey: "LastID") as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Product"
        if mode == .update{
            title = "Edit Product"
            btnAdd_Update.setTitle("Update", for: .normal)
            lbProdID.text = "\((prod?.prodID)!)"
            prodNAme.text = prod?.prodName ?? ""
            txProdDesc.text = prod?.prodDesc ?? ""
            txProdProvider.text = prod?.prodProvider ?? ""
            txProdPrice.text = "\((prod?.prodPrice)!)"
        }else{
            lbProdID.text = "\(lastID + 1)"
        }
        // Do any additional setup after loading the view.
    }
    
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
        if mode == .update{
            
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
