//
//  ViewController.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class TVDirectoryViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var tvGuideTableView: UITableView!
    @IBOutlet weak var seriesSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTVDirectory()
    }

    func configureTVDirectory() {
        tvGuideTableView.dataSource = self
        seriesSearchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: get number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: setup cell views
        return UITableViewCell()
    }
    
}

