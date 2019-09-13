//
//  ViewController.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class TVDirectoryViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: -- Properties
    var tvDirectory: [Series] = []
    
    var userSearchString = String() {
        didSet {
            if self.userSearchString == "" {
                filteredTVDirectory = tvDirectory
            } else if self.userSearchString.count >= 1 {
                SeriesFetchingClient.manager.getQuerySearch(searchEntry: self.userSearchString) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let searchedSeriesByQuery):
                            self.filteredTVDirectory = searchedSeriesByQuery
                        }
                    }
                }
            } else {
                filteredTVDirectory = tvDirectory
            }
        }
    }
    
    var filteredTVDirectory: [Series] = [] {
        didSet {
            tvGuideTableView.reloadData()
        }
    }
    
    
    //MARK: -- IBOutlets
    @IBOutlet weak var tvGuideTableView: UITableView!
    @IBOutlet weak var seriesSearchBar: UISearchBar!
    
    //MARK: -- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTVDirectory()
        loadSeries()
    }
    
    //MARK: -- DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTVDirectory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tvGuideTableView.dequeueReusableCell(withIdentifier: "tvSeriesCell", for: indexPath) as? SeriesTableViewCell else {
            print("Could not downcast as SeriesTableViewCell")
            return UITableViewCell()
        }
        let show = filteredTVDirectory[indexPath.row]
        cell.seriesTitle.text = show.name
        cell.ratingsLabel.text = "Rating: \(show.rating.average?.description ?? "N/A")"
        if let imageURL = show.image?.mediumImage {
            ImageHelper.manager.getImage(imageURL: imageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let showImage):
                        cell.seriesImage.image = showImage
                    }
                }
            }
        }
        
        return cell
    }
    
    //MARK: -- Custom Functions
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
                    self.filteredTVDirectory = allTVSeries
                }
            }
        }
    }
    
    //MARK: -- Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userSearchString = searchText.lowercased()
    }
    
    //MARK: -- Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        switch segueIdentifier {
        case "showDetailsSegue":
            guard let showSeriesVC = segue.destination as? EpisodeGuideViewController else { return }
            guard let selectedCellPath = tvGuideTableView.indexPathForSelectedRow else { return }
            EpisodesFetchingClient.manager.getShowEpisodes(showID: filteredTVDirectory[selectedCellPath.row].id) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let showEpisodes):
                    showSeriesVC.chosenSeriesEpisodes = showEpisodes
                }
            }
        default:
            return
            
        }
    }
    
}

