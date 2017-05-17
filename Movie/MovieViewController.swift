//
//  MovieViewController.swift
//  Movie
//
//  Created by tran trung thanh on 5/15/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet var imgMovie: UIImageView!
    
    @IBOutlet var lbOverview: UILabel!
    
    @IBOutlet var lbTitle: UILabel!
    var queue = OperationQueue();
    var modalMovie: movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbOverview.text = modalMovie.overview
        lbTitle.text = modalMovie.title
        
        let queue = DispatchQueue.global(qos: .default)
        queue.async() { () -> Void in
            print("asdsad");
            let img1 = Downloader.downloadImageWithURL("http://image.tmdb.org/t/p/w185"+self.modalMovie.poster!)
            DispatchQueue.main.async(execute: {
                self.imgMovie.image = img1
            })
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
