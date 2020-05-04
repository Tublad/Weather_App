
import UIKit


class HourTableCell: UITableViewCell {
    
    static var reuseId: String = "HourCell"
    static var nib: UINib {
        UINib(nibName: "HourTableCell", bundle: nil)
    }
    var weather = Weather()
    var aboutWeather = WeatherMain()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        flow.scrollDirection = .horizontal
        return collectionView
    }()
    
    func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.register(HourCollectionCell.nib, forCellWithReuseIdentifier: HourCollectionCell.reuseId)
    }
}

extension HourTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 90, height: 90)
    }
}

extension HourTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionCell.reuseId, for: indexPath) as? HourCollectionCell else { return UICollectionViewCell() }
        cell.configurator(with: weather, about: aboutWeather,  indexPath: indexPath)
        if indexPath.row != 8 {
            cell.lineView.backgroundColor = .white
            cell.lineView.alpha = 0.8
            
        } else {
            cell.lineView.backgroundColor = .clear
        }
        return cell
    }
}
