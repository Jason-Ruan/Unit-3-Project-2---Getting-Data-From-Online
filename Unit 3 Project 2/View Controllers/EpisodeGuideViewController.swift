//
//  EpisodeGuideViewController.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class EpisodeGuideViewController: UIViewController, UITableViewDataSource {
    
    var chosenSeriesName: String!
    var chosenSeriesEpisodes: [ShowEpisodes]! {
        didSet {
            DispatchQueue.main.async {
                self.showTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var showTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let chosenSeriesName = chosenSeriesName else { return "N/A" }
        return chosenSeriesName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard chosenSeriesEpisodes != nil else { return 1 }
        return chosenSeriesEpisodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard chosenSeriesEpisodes != nil else { return UITableViewCell() }
        guard let cell = showTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodeTableViewCell else { return UITableViewCell() }
        let episode = chosenSeriesEpisodes[indexPath.row]
        cell.episodeTitleLabel.text = episode.name
        cell.episodeSeasonAndEpisodeLabel.text = "S:\(episode.season) E:\(episode.episode)"
        if let episodeImageURL = episode.image?.originalImage {
            ImageHelper.manager.getImage(imageURL: episodeImageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let episodeImage):
                        cell.episodeImage.image = episodeImage
                    }
                }
            }
        }
        return cell
    }
    
    // MARK: - Navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //    }
    
}
