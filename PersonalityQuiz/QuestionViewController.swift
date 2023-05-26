//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Ednan R. Frizzera Filho on 25/05/23.
//

import UIKit

class QuestionViewController: UIViewController {

// MARK: - IBOutlets
    
    @IBOutlet var questionLabel: UILabel!
    
    // Single stack outlets
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    // Multi stack outlets
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    
    // Ranged stack outlets
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    
// MARK: - Properties
    var questions: [Question] = [
        Question(
            text: "Which food do you like the most?",
            type: .single,
            answers: [
                Answer(text: "Steak", type: .dog),
                Answer(text: "Fish", type: .cat),
                Answer(text: "Carrots", type: .rabbit),
                Answer(text: "Corn", type: .turtle)
            ]
        ),
        
        Question(
            text: "Which activities do you enjoy?",
            type: .multiple,
            answers: [
                Answer(text: "Swimming", type: .turtle),
                Answer(text: "Sleeping", type: .cat),
                Answer(text: "Cuddling", type: .rabbit),
                Answer(text: "Eating", type: .dog)
            ]
        ),
        
        Question(
            text: "How much do you enjoy car rides?",
            type: .ranged,
            answers: [
                Answer(text: "I dislike them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I love them", type: .dog)
            ]
        )
    ]
    
    var questionIndex = 0       // Keeps track of answered questions.
    
    
// MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    
// MARK: - Functions
    
    // Responsible for updating the interface - including title, navigation bar and visibility of stack views
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"             // +1 because the first index is 0, and the title should have a number higher the 0.
        questionLabel.text = currentQuestion.text                           // Current question string is assigned.
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
        func updateSingleStack(using answers: [Answer]) {
            // Shows the stack
            singleStackView.isHidden = false
            
            // Customizes the title
            singleButton1.setTitle(answers[0].text, for: .normal)
            singleButton2.setTitle(answers[1].text, for: .normal)
            singleButton3.setTitle(answers[2].text, for: .normal)
            singleButton4.setTitle(answers[3].text, for: .normal)
        }
        
        func updateMultipleStack(using answers: [Answer]) {
            // Shows the stack
            multipleStackView.isHidden = false
            
            // Customizes the title
            multiLabel1.text = answers[0].text
            multiLabel2.text = answers[1].text
            multiLabel3.text = answers[2].text
            multiLabel4.text = answers[4].text
        }
        
        func updateRangedStack(using answers: [Answer]) {
            // Shows the stack
            rangedStackView.isHidden = false
            
            // Th "first" and "last" properties allows to safely access the two Answer structs that corresponds to the label.
            rangedLabel1.text = answers.first?.text
            rangedLabel2.text = answers.last?.text
        }
    }
    
 
    
    
    
    
    
    
    
    
    
    
    
}
