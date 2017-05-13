//
//  MovieTableViewController.swift
//  Movie
//
//  Created by Cntt06 on 5/13/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    var queue = OperationQueue();
    class Downloader {
        
        class func downloadImageWithURL(_ url:String) -> UIImage! {
            print("url \(url)")
            let data = try? Data(contentsOf: URL(string: url)!)
            return UIImage(data: data!)
        }
    }

    // 1
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    // 2
    var dataTask: URLSessionDataTask?
    var results = [movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        load();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func load()
    {
        // 1
        if dataTask != nil {
            dataTask?.cancel()
        }
        // 2
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // 3
        //let expectedCharSet = NSCharacterSet.urlQueryAllowed

        // 4
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=fa682fdd6a6e82df083054c22b134a49")
        // 5
        dataTask = defaultSession.dataTask(with: url! as URL) {
            data, response, error in
            // 6
            DispatchQueue.main.async() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            // 7
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.updateResults(data)

                }
            }
        }
        // 8
        dataTask?.resume()
    }
    func updateResults(_ data: Data?) {
        results.removeAll()
        do {
            if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                
                // Get the results array
                if let array: AnyObject = response["results"] {
                    for trackDictonary in array as! [AnyObject] {
                        if let trackDictonary = trackDictonary as? [String: AnyObject] {
                            // Parse the search result
                            let overview = trackDictonary["overview"] as? String
                            let title = trackDictonary["title"] as? String
                            let poster = trackDictonary["poster_path"] as? String
                            results.append(movie(title: title, poster: poster, overview: overview))
                        } else {
                            print("Not a dictionary")
                        }
                    }
                } else {
                    print("Results key not found in dictionary")
                }
            } else {
                print("JSON Error")
            }
        } catch let error as NSError {
            print("Error parsing results: \(error.localizedDescription)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.setContentOffset(CGPoint.zero, animated: false)
        }
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell

        
        // Configure the cell...
        let moviecell = results[indexPath.row]
        cell.title.text = moviecell.title;
        cell.overview.text = moviecell.overview;
        /*
        queue = OperationQueue()
        let operation1 = BlockOperation(block: {
            let img1 = Downloader.downloadImageWithURL("http://image.tmdb.org/t/p/w185\(moviecell.poster)")
            OperationQueue.main.addOperation({
                cell.imagePoster.image = img1
            })
        })
        operation1.completionBlock = {
            operation1.completionBlock = {
                print("Operation 1 completed, cancelled:\(operation1.isCancelled) ")
            }
        }
        queue.addOperation(operation1)*/
        let queue = DispatchQueue.global(qos: .default)
        queue.async() { () -> Void in
            
            print("ertet")
            let img1 = Downloader.downloadImageWithURL("http://image.tmdb.org/t/p/w185\(moviecell.poster)")
            DispatchQueue.main.async(execute: {
                cell.imagePoster.image = img1
            })
            
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
