//
//  QuestionViewController.swift
//  Word
//
//  Created by 柳本宗達 on 2017/04/20.
//  Copyright © 2017年 柳本宗達. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var isAnswered: Bool = false
    var wordArry: [Dictionary<String, String>] = []
    var shuffledWordArray: [Dictionary<String, String>] = []
    var nowNumber: Int = 0
    
    let saveData = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        wordArry = saveData.array(forKey: "WORD") as! [Dictionary<String, String>]
        shuffle()
        questionLabel.text = shuffledWordArray[nowNumber]["english"]
    }
    
    func shuffle(){
        while wordArry.count > 0{
            let index = Int(arc4random()) % wordArry.count
            shuffledWordArray.append(wordArry[index])
            wordArry.remove(at: index)
        }
    }
    @IBAction func nextButtonTapped(){
        
        if isAnswered {
            nowNumber += 1
            answerLabel.text = ""
            
            if nowNumber < shuffledWordArray.count {
                questionLabel.text = shuffledWordArray[nowNumber]["english"]
                isAnswered = false
                nextButton.setTitle("答えを表示", for: .normal)
            }else{
                self.performSegue(withIdentifier: "toFinishView", sender: nil)
            }
        }else{
            answerLabel.text = shuffledWordArray[nowNumber]["japanese"]
            isAnswered = true
            nextButton.setTitle("次へ", for: .normal)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
