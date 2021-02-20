//
//  MovieDetailsViewController.swift
//  flixster
//
//  Created by Kristy Lau on 2/19/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    //Of type dictionary, key by strings
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(movie["title"])
        
        titleLabel.text = movie["title"] as? String
        //After setting text, grow the label until it fits that is typed in there
        titleLabel.sizeToFit()
        
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        //For the poster
        let baseURL = "https://image.tmdb.org/t/p/w185" //185 pixels wide
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseURL + posterPath) //We now have the poster URL
        
        //after installing AlamofireImage, posterView has a new function available to it
        posterView.af_setImage(withURL: posterUrl!)
        
        //For backdrop
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath) //We now have the backdrop URL, 780 is listed as available width
        
        backdropView.af_setImage(withURL: backdropUrl!)
        
        
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
