//
//  ViewController.swift
//  Project2_100days
//
//  Created by user226947 on 12/11/22.
//

import UIKit

extension UIView {
    func animateBorderWidth(toValue: CGFloat, duration: Double = 1.3) {
    let animation = CABasicAnimation(keyPath: "borderWidth")
    animation.fromValue = layer.borderWidth
    animation.toValue = toValue
    animation.duration = duration
    layer.add(animation, forKey: "Width")
    layer.borderWidth = toValue
  }
}


class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var currentQuestion = 0
    
    let maxQuestion = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany",
                      "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia",
                      "spain", "uk", "us"]


        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "score", style: .plain, target: self, action: #selector(scoreTapped))
        
        askQuestion()
        
    }
    func askQuestion(action: UIAlertAction! = nil) {
        
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        currentQuestion += 1
        
        
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        UIView.transition(with: button1, duration: 0.5, options: .transitionFlipFromRight, animations: { [self] in
            self.button1.setImage(UIImage(named: self.countries[0]), for: .normal)
        }, completion: nil)
        
        UIView.transition(with: button2, duration: 0.6, options: .transitionFlipFromRight, animations: { [self] in
            self.button2.setImage(UIImage(named: self.countries[1]), for: .normal)
        }, completion: nil)
        
        UIView.transition(with: button3, duration: 0.7, options: .transitionFlipFromRight, animations: { [self] in
            self.button3.setImage(UIImage(named: self.countries[2]), for: .normal)
        }, completion: nil)

        updateTitle()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            score += 1
            
            (sender as UIButton).layer.borderColor = UIColor.green.cgColor
            (sender as UIButton).animateBorderWidth(toValue: 55, duration: 1.3)
            (sender as UIButton).animateBorderWidth(toValue: 2)
        
            
            updateTitle()
            
            if currentQuestion < maxQuestion {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    self.askQuestion()
                });
            }
            else {
                gameOver()
            }
            
        }
        else {
            (sender as UIButton).layer.borderWidth = 55
            (sender as UIButton).layer.borderColor = UIColor.red.cgColor
            
            score -= 1
            postAlert(correct: correctAnswer)
        }
    }
    
    func updateTitle() {
        if countries[correctAnswer] == "uk" {
            title = "Flag of the UK, round: \(currentQuestion)/\(maxQuestion)"
        }
        else if countries[correctAnswer] == "us" {
            title = "Flag of the US, round: \(currentQuestion)/\(maxQuestion)"
        }
        else {
            title = "Flag of \(countries[correctAnswer].capitalized), round: \(currentQuestion)/\(maxQuestion)"
        }
    }
    
    func gameOver() {
        let scoreFinal = score
        
        score = 0
        correctAnswer = 0
        currentQuestion = 0
        
        let ac = UIAlertController(title: "Game over!", message: "Your score is \(scoreFinal)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Start new game", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    @objc func scoreTapped() {
        let ac = UIAlertController(title: "Your score is", message: "\(score) out of 10", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func postAlert(correct: Int) {
        updateTitle()

        
        if correct == 0 {
            button1.layer.borderColor = UIColor.green.cgColor
            button1.animateBorderWidth(toValue: 55, duration: 1.3)
            button1.animateBorderWidth(toValue: 2)
            
        } else if correct == 1 {
            button2.layer.borderColor = UIColor.green.cgColor
            button2.animateBorderWidth(toValue: 55, duration: 1.3)
            button2.animateBorderWidth(toValue: 2)
            
        } else if correct == 2 {
            button3.layer.borderColor = UIColor.green.cgColor
            button3.animateBorderWidth(toValue: 55, duration: 1.3)
            button3.animateBorderWidth(toValue: 2)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {

        if self.currentQuestion < self.maxQuestion {
            self.askQuestion()
        }
        else {
            self.gameOver()
        }
          
      })
    }
}
