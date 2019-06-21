//
//  MyViewController.swift
//  Recipe
//
//  Created by SWUCOMPUTER on 16/06/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class MyViewController: UIViewController {

    
    @IBOutlet var textName: UILabel!
    @IBOutlet var textIngredient: UITextView!
    @IBOutlet var textRecipe: UITextView!
    
    var detailRecipe: NSManagedObject?
    let mDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let recipe = detailRecipe {
            textName.text = recipe.value(forKey: "name") as? String
            textIngredient.text = recipe.value(forKey: "ingredient") as? String
            textRecipe.text = recipe.value(forKey: "recipe") as? String
            self.title = recipe.value(forKey: "name") as? String
        }
    }
    
    @IBAction func saveSever(_ sender: UIBarButtonItem) {
        
        if let recipe = detailRecipe {
            let name: String = (recipe.value(forKey: "name") as? String)!
            let ingredient: String = (recipe.value(forKey: "ingredient") as? String)!
            let recipe: String = (recipe.value(forKey: "recipe") as? String)!
        
        let alert = UIAlertController(title:"공유 하시겠습니까?",message: "",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in let urlString: String = "http://condi.swu.ac.kr/student/T09/login/toshare.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let myDate = formatter.string(from: self.mDate)
            let restString: String = "name=" + name + "&ingredient=" + ingredient
                + "&recipe=" + recipe + "&date" + myDate
            request.httpBody = restString.data(using: .utf8)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else { return }
                guard let receivedData = responseData else { print("Error: not receiving Data")
                    return }
                if let utf8Data = String(data: receivedData, encoding: .utf8) {
                    DispatchQueue.main.async { // for Main Thread Checker
                    print(utf8Data) // php에서 출력한 echo data가 debug 창에 표시됨
                    }
                }
            }
            task.resume()
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let loginView = storyboard.instantiateViewController(withIdentifier: "LoginView")
            //self.present(loginView, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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
