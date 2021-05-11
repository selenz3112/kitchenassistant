//
//  RecipeViewController.swift
//  Kitchen Assistant
//
//  Created by user178354 on 4/30/21.
//  Copyright © 2021 user178354. All rights reserved.
//

import UIKit
import Firebase

class RecipeViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var recipeTableView: UITableView!
    var recipeDetails: [String] = []
    var realRecipeInstructions: [Any] = []
    var recipeInstructions2: [Any] = []
    var randomRecipe: String!
    var foodName: [Any] = []
    var realFoodName: [String] = []
    var arrayCount = 0
    var finalInstructions: [Any] = []
    var allrecipes: [String : String] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignChosenRecipe()
       
        recipeTableView.dataSource = self
             print(randomRecipe!)
      //  print(finalInstructions)
    }
    
    func assignChosenRecipe(){
        var ref = Database.database().reference()
        ref.observeSingleEvent(of: .value) { (snapshot) in
            
            for data in snapshot.children.allObjects as! [DataSnapshot] {
                let meal = data.key
                let recipeAndDetails = data.value as! NSDictionary
                let recipeName = recipeAndDetails.allKeys
                let recipeInstructions = recipeAndDetails.allValues
                
                self.foodName.append(contentsOf: recipeName)
                self.realRecipeInstructions.append(recipeInstructions)
           
                
                while self.arrayCount < self.foodName.count{
                    self.realFoodName.append(self.foodName[self.arrayCount] as! String)
                    self.arrayCount += 1
                }
       
            }
            DispatchQueue.main.async {
                self.recipeTableView.reloadData()
                             }
          var dictCount = self.realFoodName.firstIndex(of: self.randomRecipe)!
            print(dictCount)
            self.recipeInstructions2.append(recipeAndDetails[dictCount])
            print(self.recipeInstructions2)
            print(self.realFoodName)
            print(self.randomRecipe)
            }
  
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return recipeInstructions2.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
          let cell2 = recipeTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
          cell2.textLabel?.text = "\(recipeInstructions2[indexPath.row])"
          return cell2
      }
        
    }
   
    
    
    
    

