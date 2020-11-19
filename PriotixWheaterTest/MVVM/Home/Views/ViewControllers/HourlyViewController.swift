//
//  HourlyViewController.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/23/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

class HourlyViewController: UIViewController {
    
    @IBOutlet var adapter: HourlyListAdapter!
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = HourlyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel() 
    }
    
    func setupCollectionView() {
        collectionView.register(UINib.init(nibName: "HourlyCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: HourlyCollectionViewCell.nameOfClass)
    }
    
    func setupViewModel() {
        self.viewModel.hourlyViewModelDelegate = self
    }
    
}

extension HourlyViewController: HourlyViewModelDelegate {
    func didRecive(weathers: [Weather]?) {
        guard let weathers = weathers else { return }
        adapter.weathers = weathers
        collectionView.reloadData()
    }
}
