//
//  ViewController.swift
//  MovieAPP
//
//  Created by ahmed on 10/01/2023.
//

import UIKit
import Kingfisher
import Reachability
import CoreData
class ViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource,Pmovie {
    func getMoviewItem(movie : MovieData) -> () {
        movieList.append(movie)
        table.reloadData()
    }
    
    
    @IBOutlet weak var table: UITableView!
    var deletedMovieList = [MovieData] ()
    var movieList = [MovieData] ()
    var tempMovieArray : [NSManagedObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         let movie1 = MovieModel(title: "cast away", image: "1.png", rating: 3.4, releaseYear: 2012, genre: ["Action" , "Action"] )
         
         let movie2 = MovieModel(title: "Shutter Island", image: "1.png", rating: 3.4, releaseYear: 2012, genre: ["Action" , "Action"] )
         
         let movie3 = MovieModel(title: "salam ya sa7by", image: "1.png", rating: 3.4, releaseYear: 2012, genre: ["Action" , "Action"] )
         
         let movie4 = MovieModel(title: "cast away", image: "1.png", rating: 3.4, releaseYear: 2012, genre: ["Action" , "Action"] )
         
         let movie5 = MovieModel(title: "cast away", image: "1.png", rating: 3.4, releaseYear: 2012, genre: ["Action" , "Action"] )
         
         let movie6 = MovieModel(title: "cast away", image: "1.png", rating: 3.4, releaseYear: 2012, genre: ["Action" , "Action"] )
         movieList.append(movie1)
         movieList.append(movie2)
         movieList.append(movie3)
         movieList.append(movie4)
         movieList.append(movie5)
         movieList.append(movie6)
         */
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        
        
        if Reachability.forInternetConnection().isReachable(){
            fetchData()
        }
        else
        {
            fetchDataFromCoreData()
        }
    }


    @IBAction func addItem(_ sender: Any) {
        let obj : AddViewController = self.storyboard?.instantiateViewController(withIdentifier: "add") as! AddViewController
        obj.delegateProtocol = self
        
        self.navigationController?.pushViewController(obj, animated: true)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        cell.nameView.text = movieList[indexPath.row].title
        cell.nameView.adjustsFontForContentSizeCategory = true
        cell.nameView.adjustsFontSizeToFitWidth = true
        
        cell.yearView.text = movieList[indexPath.row].rank
        cell.descriptionView.text = movieList[indexPath.row].gross
        let url = URL(string: (movieList[indexPath.row].image ?? "https://m.media-amazon.com/images/M/MV5BZDc4MzVkNzYtZTRiZC00ODYwLWJjZmMtMDIyNjQ1M2M1OGM2XkEyXkFqcGdeQXVyMDA4NzMyOA@@._V1_Ratio0.6716_AL_.jpg" ))
        cell.movieImage?.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj : DetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        obj.movieItem = movieList[indexPath.row]
        
        self.navigationController?.pushViewController(obj, animated: true)

    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let deletedMovieItem: MovieData = self.movieList[indexPath.row]
        deletedMovieList.append(deletedMovieItem)
        self.movieList.remove(at: indexPath.row)
        self.table.deleteRows(at: [indexPath], with: .left)
    }

    func undoDeleting (){
        movieList.append(contentsOf: deletedMovieList)
        table.reloadData()
        deletedMovieList.removeAll()
    }

    @IBAction func undoBtn(_ sender: Any) {
        undoDeleting()
    }
    
}

extension ViewController {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Movie List"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
    func fetchData(){
        fetchMovieData { response in
            /*
             // using filter
            let tempList:[MovieData] = response?.items?.filter{$0.title! > ""} ?? []

            
            guard let movieList = tempList else
             {
             self.movieList.removeAll()
             self.movieList.append(contentsOf: (response?.items) ?? [])
             self.saveDataIntoCoreData(movieList: self.movieList)
             DispatchQueue.main.async {
                 self.table.reloadData()
             }
             return
             }
             DispatchQueue.main.async {
                 self.table.reloadData()
             }
             
             */
            
            // using Equatable
            if(self.movieList == (response?.items))
            {
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
            else{
                self.movieList.removeAll()
                self.movieList.append(contentsOf: (response?.items) ?? [])
                self.saveDataIntoCoreData(movieList: self.movieList)
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
        }
    }
}

extension ViewController
{
    
    // for loop 3la l array bta3 l table b3dah n-save
    func saveDataIntoCoreData(movieList:[MovieData]){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
        // user defult ll array
        // remove intersaction
        
        for item in movieList{
            movie.setValue(item.title, forKey: "title")
            movie.setValue(item.image, forKey: "image")
            movie.setValue(item.rank, forKey: "rank")
            movie.setValue(item.weeks, forKey: "weeks")
            movie.setValue(item.weekend, forKey: "weekend")
            movie.setValue(item.gross, forKey: "gross")
            do {
                try managedContext.save()
                print("saving \(String(describing: item.title)) done")
            }
            catch let error as NSError{
                print(error)
                print("saving \(item) error")
            }
        }
    }
    
    func fetchDataFromCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchMovieRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
        let predicate =  NSPredicate(format: "title >= %@","")

        fetchMovieRequest.predicate = predicate

        do{
                tempMovieArray = try managedContext.fetch(fetchMovieRequest)
                movieList.removeAll()
                for item in (tempMovieArray ?? [])
                {
                    movieList.append(MovieData(id: "" ,
                                               rank: item.value(forKey: "rank") as? String,
                                               title: item.value(forKey: "title") as? String,
                                               image: item.value(forKey: "image") as? String,
                                               weekend: item.value(forKey: "weekend") as? String,
                                               gross: item.value(forKey: "gross") as? String,
                                               weeks: item.value(forKey: "weeks") as? String))
                    
                    print("fetching \(String(describing: item.value(forKey: "title"))) done")
                    
                }
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
}
