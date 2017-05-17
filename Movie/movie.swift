//
//  movie.swift
//  Movie
//
//  Created by Cntt06 on 5/13/17.
//  Copyright © 2017 Cntt06. All rights reserved.
//

import Foundation
import UIKit
class movie {
    var title: String?
    var poster: String?
    var overview: String?
    
    init(title: String?, poster: String?, overview: String?) {
        self.title = title
        self.poster = poster
        self.overview = overview
    }
}
