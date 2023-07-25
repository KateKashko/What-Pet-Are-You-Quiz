//
//  ViewController.swift
//  What Pet Are You? Quiz
//
//  Created by Kate Kashko on 25.07.2023.
//

import UIKit

final class QuestionsViewController: UIViewController {

        @IBOutlet var questionLabel: UILabel!
        @IBOutlet var questionProgressView: UIProgressView!
        
        @IBOutlet var singleStackView: UIStackView!
        @IBOutlet var singleButtons: [UIButton]!
        
        @IBOutlet var multipleStackView: UIStackView!
        @IBOutlet var multipleLabels: [UILabel]!
        @IBOutlet var multipleSwitches: [UISwitch]!
        
        @IBOutlet var rangedStackView: UIStackView!
        @IBOutlet var rangedLabels: [UILabel]!
        @IBOutlet var rangedSlider: UISlider! {
            didSet {
                let answerCount = Float(currentAnswers.count - 1)
                rangedSlider.maximumValue = answerCount
                rangedSlider.value = answerCount / 2
            }
        }
        
        private let questions = Question.getQuestions()
        private var answersChosen: [Answer] = []
        private var questionIndex = 0
        private var currentAnswers: [Answer] {
            questions[questionIndex].answers
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let resultVC = segue.destination as? ResultViewController else { return }
            resultVC.answers = answersChosen
        }
        
        @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
            guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
            let answer = currentAnswers[buttonIndex]
            answersChosen.append(answer)
            nextQuestion()
        }
        
        @IBAction func multipleButtonAnswerPressed() {
            for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
                if multipleSwitch.isOn {
                    answersChosen.append(answer)
                }
            }
            nextQuestion()
        }
        
        @IBAction func rangedAnswerButtonPressed() {
            let index = lrintf(rangedSlider.value)
            answersChosen.append(currentAnswers[index])
            nextQuestion()
        }
    }

    // MARK: - Private Methods
    extension QuestionsViewController {
        private func updateUI() {
            // Hide stacks
            for stackView in [singleStackView, multipleStackView, rangedStackView] {
                stackView?.isHidden = true
            }
            
            // Get current question
            let currentQuestion = questions[questionIndex]
            
            // Set current question for question label
            questionLabel.text = currentQuestion.title
            
            // Calculate progress
            let totalProgress = Float(questionIndex) / Float(questions.count)
            
            // Set progress for questionProgressView
            questionProgressView.setProgress(totalProgress, animated: true)
            
            // Set navigation title
            title = "Quiz № \(questionIndex + 1) from \(questions.count)"
            
            showCurrentAnswers(for: currentQuestion.responseType)
        }
        
        private func showCurrentAnswers(for type: ResponseType) {
            switch type {
            case .single: showSingleStackView(with: currentAnswers)
            case .multiple: showMultipleStackView(with: currentAnswers)
            case .ranged: showRangedStackView(with: currentAnswers)
            }
        }
        
        private func showSingleStackView(with answers: [Answer]) {
            singleStackView.isHidden = false
            
            for (button, answer) in zip(singleButtons, answers) {
                button.setTitle(answer.title, for: .normal)
            }
        }
        
        private func showMultipleStackView(with answers: [Answer]) {
            multipleStackView.isHidden = false
            
            for (label, answer) in zip(multipleLabels, answers) {
                label.text = answer.title
            }
        }
        
        private func showRangedStackView(with answers: [Answer]) {
            rangedStackView.isHidden = false
            
            rangedLabels.first?.text = answers.first?.title
            rangedLabels.last?.text = answers.last?.title
        }
        
        private func nextQuestion() {
            questionIndex += 1
            
            if questionIndex < questions.count {
                updateUI()
                return
            }
            
            performSegue(withIdentifier: "showResult", sender: nil)
        }
    }


