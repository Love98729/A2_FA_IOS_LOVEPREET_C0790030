

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var prodID: Int16
    @NSManaged public var prodName: String?
    @NSManaged public var prodDesc: String?
    @NSManaged public var prodPrice: Float
    @NSManaged public var prodProvider: String?

}
