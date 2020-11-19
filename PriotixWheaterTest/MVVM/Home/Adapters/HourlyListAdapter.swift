//
//  HourlyListAdapter.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import Foundation
import UIKit

class HourlyListAdapter: NSObject {
    var weathers = [Weather]()
}

extension HourlyListAdapter : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 88, height: 180)
        return size
    }
}

extension HourlyListAdapter : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.nameOfClass, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? HourlyCollectionViewCell {
            cell.setupCell(weather: weathers[indexPath.row])
        }
    }
    
}
