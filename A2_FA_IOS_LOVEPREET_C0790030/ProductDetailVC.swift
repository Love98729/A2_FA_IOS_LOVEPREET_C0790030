
import UIKit

class ProductDetailVC: UIViewController {

    @IBOutlet weak var price_of_product: UILabel!
    @IBOutlet weak var Provider: UILabel!
    @IBOutlet weak var ProdLabel: UILabel!
    @IBOutlet weak var Productnamme: UILabel!
    @IBOutlet weak var ProductID: UILabel!
    
    var prod : Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = prod.prodName ?? ""
        
        Productnamme.text = prod.prodName ?? ""
        ProductID.text = "\(prod.prodID)"
        ProdLabel.text = prod.prodDesc ?? ""
        Provider.text = prod.prodProvider ?? ""
        price_of_product.text = "\(prod.prodPrice)"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
