//
//  SearchViewController.swift
//  PriotixWheaterTest
//
//  Created by Myasnik Tadevosyan on 8/21/19.
//  Copyright © 2019 Myasnik Tadevosyan. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate {
    func didSelectItem(weather: Weather)
}

class SearchViewController: UITableViewController {
    
    @IBOutlet var searchAdapter: SearchViewAdapter!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var infoLabel: UILabel!
    var delegate:SearchViewControllerDelegate?
    let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchAdapter.delegate = self
        setupViewModel()
        setupView()
    }
    
    func setupView() {
        self.tableView.backgroundView = UIImageView.init(image: UIImage.init(named: "homeBG"))
    }
    
    func setupViewModel() {
        self.viewModel.searchViewModelDelegate = self
    }
    
}

extension SearchViewController: SearchViewModelDelegate {
    func didRecive(weather: Weather?) {
        if let weather = weather {
            searchAdapter.searchResult.removeAll()
            self.infoLabel.isHidden = true
            searchAdapter.searchResult.append(weather)
        } else {
            searchAdapter.searchResult.removeAll()
            self.infoLabel.text = "No result found"
        }
        self.tableView.reloadData()
    }
}

extension SearchViewController: SearchViewAdapterDelegate {
    func didSelectItem(weather: Weather) {
        delegate?.didSelectItem(weather: weather)
        self.navigationController?.popViewController(animated: true)
    }
    
    func didChangeSearchBarSearchText(text: String) {
        infoLabel.isHidden = false
        infoLabel.text = "Searching..."
        viewModel.getCountry(text: text)
    }
}
