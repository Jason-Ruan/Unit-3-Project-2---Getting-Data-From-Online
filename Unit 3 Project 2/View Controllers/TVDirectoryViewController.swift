//
//  ViewController.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class TVDirectoryViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    var tvDirectory: [Series] = [] {
        didSet {
            tvGuideTableView.reloadData()
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var tvGuideTableView: UITableView!
    @IBOutlet weak var seriesSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTVDirectory()
        loadSeries()
    }
    
    func configureTVDirectory() {
        tvGuideTableView.dataSource = self
        seriesSearchBar.delegate = self
    }
    
    func loadSeries() {
        SeriesFetchingClient.manager.getSeries { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let allTVSeries):
                    self.tvDirectory = allTVSeries
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvDirectory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tvGuideTableView.dequeueReusableCell(withIdentifier: "tvSeriesCell", for: indexPath) as? SeriesTableViewCell else {
            print("Could not downcast as SeriesTableViewCell")
            return UITableViewCell()
        }
        let show = tvDirectory[indexPath.row]
        cell.seriesTitle.text = show.name
        ImageHelper.manager.getImage(imageURL: show.image.mediumImage) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let showImage):
                    cell.seriesImage.image = showImage
                }
            }
        }
        
        return cell
    }
    
}

