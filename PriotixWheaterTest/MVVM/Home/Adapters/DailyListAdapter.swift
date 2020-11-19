//
//  DailyListAdapter.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

class DailyListAdapter: NSObject {
    var weathers = [Weather]()
}

extension DailyListAdapter : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 88, height: 100)
        return size
    }
}

extension DailyListAdapter : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCollectionViewCell.nameOfClass, for: indexPath) as? DailyCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DailyCollectionViewCell {
            cell.setupCell(weather: weathers[indexPath.row])
        }
    }
    
}
