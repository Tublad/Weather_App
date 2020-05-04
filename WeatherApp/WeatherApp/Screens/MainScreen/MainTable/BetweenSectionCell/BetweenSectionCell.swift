
import UIKit

class BetweenSectionCell: UITableViewCell {
    
    static var reuseId: String = "BetweenCell"
    static var nib: UINib {
        UINib(nibName: "BetweenSectionCell", bundle: nil)
    }
    @IBOutlet weak var lineView: UIView!
}
