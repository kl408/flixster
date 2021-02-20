//
//  MoviesViewController.swift
//  flixster
//
//  Created by Kristy Lau on 2/10/21.
//

import UIKit
import AlamofireImage //imported library via pods

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    

    @IBOutlet weak var tableView: UITableView!
    
    
    //Creating an array of dictionaries
    var movies = [[String:Any]]() //Parenthesis at the end to indiciate creation of something
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        //print("Hello")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              //Look into dataDictionary and get out results
              self.movies = dataDictionary["results"] as! [[String:Any]]
              //after this, download of movies is complete
            
              self.tableView.reloadData() //reload the data to call the functions below again
              //Ex. it will call first function which gets 20 movies, then the second function will repeat 20 times
            
              //print(dataDictionary) //prints out contents of API
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //movies.count establishes number of rows
        return movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //For this particular row, give the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell //if another cell is off-screen, give recycled cell, otherwise create new one if no recycled cells
        
        //Will access first, second.. movie and store it in variable movie
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String //would like this title to be a string
        let synopsis = movie["overview"] as! String
        
        //question mark: swift for optionals?
        //cell.textLabel!.text = title
        cell.titleLabel.text = title //We want titleLabel now, not textLabel
        cell.synopsisLabel.text = synopsis
        
        //For poster
        let baseURL = "https://image.tmdb.org/t/p/w185" //185 pixels wide
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseURL + posterPath) //We now have the poster URL
        
        //after installing AlamofireImage, posterView has a new function available to it
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     
        print("Loading up the details screen")
     
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for:cell)!
        let movie = movies[indexPath.row]
        
        //Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController //cast
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
