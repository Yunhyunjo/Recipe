//
//  ShareViewController.swift
//  Recipe
//
//  Created by SWUCOMPUTER on 16/06/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ShareViewController: UIViewController {

    @IBOutlet var textName: UILabel!
    @IBOutlet var textIngredient: UITextView!
    @IBOutlet var textRecipe: UITextView!
    
    var selectedData: RecipeData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        guard let recipeData = selectedData else { return }
        textName.text = recipeData.name
        textIngredient.text = recipeData.ingredient
        textRecipe.text = recipeData.recipe
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func saveCore(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Recipes", in:context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(textName.text, forKey: "name")
        object.setValue(textIngredient.text, forKey: "ingredient")
        object.setValue(textRecipe.text, forKey: "recipe")
        object.setValue(Date(),forKey:"date")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
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
