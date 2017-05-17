//
//  download.swift
//  Movie
//
//  Created by tran trung thanh on 5/15/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import Foundation
import UIKit
class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}
