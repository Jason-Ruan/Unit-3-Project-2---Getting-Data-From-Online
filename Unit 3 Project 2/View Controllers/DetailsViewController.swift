//
//  DetailsViewController.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var episode: ShowEpisodes!
    
    //MARK: IBOutlets
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeSeasonAndEpisodeLabel: UILabel!
    @IBOutlet weak var episodeSummaryTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetailsViews()
    }
    
    func setUpDetailsViews() {
        episodeTitleLabel.text = episode.name
        episodeSeasonAndEpisodeLabel.text = "Season: \(episode.season)  Episode: \(episode.episode)"
        episodeSummaryTextView.text = episode.summary
        if let imageURL = episode.image?.originalImage {
            ImageHelper.manager.getImage(imageURL: imageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let imageForEpisode):
                        self.episodeImage.image = imageForEpisode
                    }
                }
            }
        }
    }
    
}
