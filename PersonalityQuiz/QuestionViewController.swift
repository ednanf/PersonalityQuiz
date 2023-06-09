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
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    // Ranged stack outlets
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    @IBOutlet var rangedSlider: UISlider!
    
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
    var answerChosen: [Answer] = []
    
    
// MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    
// MARK: - IBActions
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answerChosen.append(currentAnswers[0])
        case singleButton2:
            answerChosen.append(currentAnswers[1])
        case singleButton3:
            answerChosen.append(currentAnswers[2])
        case singleButton4:
            answerChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
        
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answerChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answerChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answerChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answerChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
        
    }
    
    @IBAction func rangedAnswerButoonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))        // Converts the slider's value to an array index.
        
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answerChosen)                 // Returns the correct initializer -- otherwise it will use the required default one and crash.
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
        
        navigationItem.title = "Question #\(questionIndex + 1)"                             // +1 because the first index is 0, and the title should have a number higher the 0.
        questionLabel.text = currentQuestion.text                                           // Current question string is assigned.
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
            
            // Defaults switches to off
            
            multiSwitch1.isOn = false
            multiSwitch2.isOn = false
            multiSwitch3.isOn = false
            multiSwitch4.isOn = false
            
            // Customizes the title
            multiLabel1.text = answers[0].text
            multiLabel2.text = answers[1].text
            multiLabel3.text = answers[2].text
            multiLabel4.text = answers[3].text
        }
        
        func updateRangedStack(using answers: [Answer]) {
            // Shows the stack
            rangedStackView.isHidden = false
            
            // Default slider position
            rangedSlider.setValue(0.5, animated: false)
            
            // Th "first" and "last" properties allows to safely access the two Answer structs that corresponds to the label.
            rangedLabel1.text = answers.first?.text
            rangedLabel2.text = answers.last?.text
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
