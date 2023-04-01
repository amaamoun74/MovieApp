//
//  AddViewController.swift
//  MovieAPP
//
//  Created by ahmed on 11/01/2023.
//

import UIKit

class AddViewController: UIViewController {
    var delegateProtocol: Pmovie?
    var movie:MovieData? = MovieData()
    
    @IBOutlet weak var descriptionView: UITextField!
    @IBOutlet weak var imgv: UIImageView!
    // @IBOutlet weak var tf_image: UITextField!
    @IBOutlet weak var tf_title: UITextField!
    @IBOutlet weak var tf_year: UITextField!
    @IBOutlet weak var tf_type: UITextField!
    @IBOutlet weak var tf_rate: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func setImageBtn(_ sender: Any) {
        imagePicker()
    }
    
    @IBAction func addItemToMovieList(_ sender: Any) {
        if validateUserInput()
        {
            showSuccessAlert()
        }
        else {
            showErrorAlert()
        }
    }
    
    func showSuccessAlert(){
        let alert : UIAlertController = UIAlertController(title:"Add successed" , message: "do u want to go back?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default , handler: { action in
            self.getMovieData()
            self.delegateProtocol?.getMoviewItem(movie:self.movie!)
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel , handler: nil))
        self.present(alert, animated: true , completion: nil )
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func getMovieData()
    {
            let movieName = tf_title.text!
            let MovieImage = imgv.image!
            //   let movieImage = tf_image.text!
            let movieType = tf_type.text!
            let movieRate = Float(tf_rate.text!)
            let movieYear = Int(tf_year.text!)
            let movieDiscriptionInput = descriptionView.text!
            
            /*movie = MovieModel(movieTitle: movieName, movieDescription:movieDiscriptionInput, releaseYear: movieYear, genre: [movieType], rating: movieRate, movieImage:MovieImage)*/
    }
}


extension AddViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePicker(){
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(picker, animated: true , completion: nil)
        }
        else
        {
            print("error")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage]
        imgv.image = img as? UIImage
        self.dismiss(animated: true,completion: nil)
    }
    
    func validateUserInput() -> Bool{
        if tf_title.text == nil
            || descriptionView.text == nil
            || tf_type.text == nil
            || tf_rate.text == nil
            || tf_year.text == nil
            || imgv.image == nil
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func showErrorAlert(){
        let alert : UIAlertController = UIAlertController(title:"Error" , message: "please fill all attributes", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel , handler: nil))
        self.present(alert, animated: true , completion: nil )
    }
    
}
