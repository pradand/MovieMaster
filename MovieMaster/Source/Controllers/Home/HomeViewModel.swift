//
//  HomeViewModel.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 28/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation

class HomeViewModel: MoviesViewModel {
    var nowPlayingViewModel = NowPlayingViewModel()
    var popularViewModel = PopularViewModel()
    var upComingViewModel = UpComingViewModel()
}
