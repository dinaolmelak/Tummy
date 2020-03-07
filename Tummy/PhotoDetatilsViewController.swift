//
//  PhotoDetatilsViewController.swift
//  Tummy
//
//  Created by Dinaol Melak on 3/3/20.
//  Copyright © 2020 Dinaol Melak. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoDetatilsViewController: UIViewController {

    var givenPost: [String: Any]?
    @IBOutlet weak var detailedPhotoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let post = givenPost{
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
                
                self.detailedPhotoImageView.af_setImage(withURL: url)
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
