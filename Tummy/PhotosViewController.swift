//
//  PhotosViewController.swift
//  Tummy
//
//  Created by Dinaol Melak on 2/27/20.
//  Copyright © 2020 Dinaol Melak. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts: [[String: Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data,
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              //print(dataDictionary)

              // TODO: Get the posts and store in posts property
              let myResponse = dataDictionary["response"] as! [String:Any]
              self.posts = myResponse["posts"] as! [[String: Any]]
              // TODO: Reload the table view
              print(self.posts)
              self.tableView.reloadData()
          }
        }
        task.resume()
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
       
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let post = posts[indexPath.row] // iterating through the item in posts using indexPath.row -> which is an int
        if let photos = post["photos"] as? [[String: Any]]{
            // 1. Get the first photo in the photos array
            let photo = photos[0]
            // 2. Get the original size dictionary from the photo
            let originalSize = photo["original_size"] as! [String: Any]
            // 3. Get the url string from the original size dictionary
            let urlString = originalSize["url"] as! String
            // 4. Create a URL using the urlString
            let url = URL(string: urlString)!
            
            
            
            // Call the AlamofireImage method, af_setImage(withURL:) on your image view by passing the url
            
            cell.photoUIImage.af_setImage(withURL: url)
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let vc = segue.destination as! PhotoDetatilsViewController
        
        let cell = sender as! PhotosCell
        
        let indexPath = tableView.indexPath(for: cell)!
        
        //vc.detailedPhotoImageView = cell.photoUIImage
        let post = posts[indexPath.row]
        vc.givenPost = post
        
    }
    

}
