//
//  DailyCollectionViewController.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {
    
    @IBOutlet var adapter: DailyListAdapter!
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = DailyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel()
    }

    func setupViewModel() {
        self.viewModel.dailyViewModelDelegate = self
    }
    
    func setupCollectionView() {
        collectionView.register(UINib.init(nibName: "DailyCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: DailyCollectionViewCell.nameOfClass)
    }
    
}

extension DailyViewController: DailyViewModelDelegate {
    func didRecive(weathers: [Weather]?) {
        guard let weathers = weathers else { return }
        adapter.weathers = weathers
        collectionView.reloadData()
    }
}
