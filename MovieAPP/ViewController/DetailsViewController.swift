//
//  DetailsViewController.swift
//  MovieAPP
//
//  Created by ahmed on 10/01/2023.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var movieDescriptionView: UITextView!
    @IBOutlet weak var movieRateView: UILabel!
    @IBOutlet weak var movieYearView: UILabel!
    @IBOutlet weak var movieTypeView: UILabel!
    @IBOutlet weak var moviewNameView: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    var movieItem =  MovieData()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.movieConfigration()
    }
    
    func movieConfigration(){
        movieRateView.text = "Rank: " + ((movieItem.rank) ?? "")
        
        movieYearView.text = "Gross: " + ((movieItem.gross) ?? "")
        let url = URL(string: (movieItem.image ?? "https://m.media-amazon.com/images/M/MV5BZDc4MzVkNzYtZTRiZC00ODYwLWJjZmMtMDIyNjQ1M2M1OGM2XkEyXkFqcGdeQXVyMDA4NzMyOA@@._V1_Ratio0.6716_AL_.jpg" ))
        movieImageView?.kf.setImage(with: url)
        
        moviewNameView.text = movieItem.title
        moviewNameView.adjustsFontForContentSizeCategory = true
        moviewNameView.adjustsFontSizeToFitWidth = true
        
        movieDescriptionView.text = movieItem.weekend
        
       /* for i in movieItem.genre! {
            movieTypeView.text! += String((" - " + i + " - "))
        }*/
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
