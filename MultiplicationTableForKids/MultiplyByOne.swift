//
//  MultiplyByOne.swift
//  MultiplicationTableForKids
//
//  Created by Vakhtang on 22.07.2023.
//

import SwiftUI

struct MultiplyByOne: View {
    
    
    @State private var choiceArray = [0, 1, 2, 3]
    @State private var firstNumber = 1
    @State private var secondNumber = Int.random(in: 2...20)
    @State private var multiplyNumber = 1
    @State private var score = 0
    @State private var enabled = 0.0
    @State private var isCorrectAnswer = false
    @State private var isGameOver = false
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var isGameStarted = false
    @State private var selectedAnswer: Int?
    
    var body: some View {
        
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: Color(UIColor.orange), location: 0),
                Gradient.Stop(color: Color(UIColor.red), location: 0.17),
                Gradient.Stop(color: Color(UIColor.yellow), location: 0.75),
                Gradient.Stop(color: Color(UIColor.orange), location: 1),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                if isGameStarted {
                    Text("\(firstNumber) x \(secondNumber)")
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                    Spacer()
                    ForEach(0..<4) { index in
                        Button {
                            withAnimation {
                                answerIsCorrect(answer: choiceArray[index])
                                
                            }
                            
                        } label: {
                            AnswerButton(number: choiceArray[index])
                                .rotation3DEffect(.degrees(index == correctAnswer && isCorrectAnswer ? enabled : 0), axis: (x: 0, y: 1, z: 0))
                                
                        }
                        
                    }
                    
                    Spacer()
                    Text("Score \(score)")
                } else {
                    Button("Start") {
                        isGameStarted = true
                        generateAnswers()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    

    func generateAnswers() {
        
        multiplyNumber = 1
        secondNumber = Int.random(in: 1...20)
        var answerList = [Int]()

        correctAnswer = firstNumber * secondNumber
        for _ in 0...2 {
            answerList.append(Int.random(in: 1...20))
        }
        answerList.append(correctAnswer)
        choiceArray = answerList.shuffled()
        isCorrectAnswer = false
        enabled = 0
    }
    
    func answerIsCorrect(answer: Int) {
        
        if answer == correctAnswer {
            isCorrectAnswer = true
            score += 1
            enabled += 360
            
        } else {
            score -= 1
        }
    }
}

struct MultiplyByOne_Previews: PreviewProvider {
    static var previews: some View {
        MultiplyByOne()
    }
}
