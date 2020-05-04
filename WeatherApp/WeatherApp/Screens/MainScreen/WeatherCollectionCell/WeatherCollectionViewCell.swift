
import Foundation
import UIKit


class MainCollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "FullMainCell"
    
    var tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupElements()
        setupConstraints()
        
    }
    
    func setupElements() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainCollectionViewCell {
    
    func setupConstraints() {
        addSubview(tableView)
        
        tableView.backgroundColor = .clear
        
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        footerView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footerView
        
        tableView.register(MainTableCell.nib, forCellReuseIdentifier: MainTableCell.reuseId)
        tableView.register(HourTableCell.nib, forCellReuseIdentifier: HourTableCell.reuseId)
        tableView.register(WeekTableCell.nib, forCellReuseIdentifier: WeekTableCell.reuseId)
        tableView.register(BetweenSectionCell.nib, forCellReuseIdentifier: BetweenSectionCell.reuseId)
    }
}

