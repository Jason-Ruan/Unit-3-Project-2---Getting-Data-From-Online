//
//  EpisodeGuideViewController.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class EpisodeGuideViewController: UIViewController, UITableViewDataSource {
    
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

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        return UITableViewCell()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }

}
