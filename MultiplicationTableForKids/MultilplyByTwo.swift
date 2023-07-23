//
//  MultilplyByTwo.swift
//  MultiplicationTableForKids
//
//  Created by Vakhtang on 22.07.2023.
//

import SwiftUI

struct MultilplyByTwo: View {
    
    @State private var choiceArray = [0, 1, 2, 3]
    @State private var animationStates = [false, false, false, false]
    @State private var answers: Int?
    @State private var secondNumber = Int.random(in: 2...20)
    @State private var multiplyNumber = 2
    @State private var score = 0
    @State private var enabled = 0.0
    @State private var isCorrectAnswer = false
    @State private var isCorrect = false
    @State private var correctAnswerShowing = false
    @State private var showCorrectAnswer = false
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var isGameStarted = false
    @State private var selectedAnswer: Int?
    @State private var animationAmount = 1.0
    
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
                    Text("\(multiplyNumber) x \(secondNumber)")
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                    Spacer()
                    if isCorrect {
                        Button("Next") {
                            generateAnswers()
                        }
                        .padding(50)
                        .frame(width: 200, height: 80)
                        .background(.green)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: Color.black.opacity(0.6), radius: 10, y: 5)
                    }
                    ForEach(0..<4) { index in
                        Button {
                            withAnimation {
                                answerIsCorrect(answer: choiceArray[index], animation: index)
                                correctAnswerShowing = true
                                showCorrectAnswer = false
                            }
                        } label: {
                            AnswerButton(number: choiceArray[index])
                                .rotation3DEffect(.degrees(index == answers ? enabled : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(index != answers && isCorrectAnswer ? 0.25 : 1)
                                .background(index == answers && isCorrectAnswer ? Color.yellow : Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .scaleEffect(index != answers && isCorrectAnswer ? 0.8 : 1.0)
                                .shadow(color: Color.black.opacity(0.6), radius: 10, y: 5)
                                .overlay(content: {
                                    if index == answers && isCorrectAnswer {
                                        Text("+ 1 score")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(UIColor.green))

                                    }
                                })
                                .opacity(showCorrectAnswer ? 0 : 1)
                        }
                    }
                    
                    Spacer()
                    Text("Score \(score)")
                        .foregroundColor(Color.black)
                        .font(.title)
                } else {
                    Spacer()
                    Button("Start") {
                        isGameStarted = true
                        generateAnswers()
                    }
                    .padding(50)
                    .frame(width: 200, height: 80)
                    .background(.yellow)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(color: Color.black.opacity(0.6), radius: 10, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.red)
                            .scaleEffect(animationAmount)
                            .opacity(2 - animationAmount)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                                value: animationAmount
                            )
                    )
                    .onAppear{
                        animationAmount = 3
                    }
                }
                Spacer()
            }
            if correctAnswerShowing {
                if showCorrectAnswer {
                    VStack(spacing: 20) {
                        Button("Next") {
                            generateAnswers()
                        }
                        .frame(width: 200, height: 80)
                        .background(.red)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: Color.black.opacity(0.6), radius: 10, y: 5)
                        .padding()
                        Text("Correct answer is")
                            .foregroundColor(Color.white)
                            .font(.title)
                        Text("\(correctAnswer)")
                            .frame(width: 200, height: 80)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .shadow(color: Color.black.opacity(0.6), radius: 10, y: 5)
                    }
                    Spacer()
                }
            }
        }
    }
    
    
    func generateAnswers() {
        
        multiplyNumber = 2
        secondNumber = Int.random(in: 1...20)
        var answerList = [Int]()
        
        correctAnswer = multiplyNumber * secondNumber
        for _ in 0...2 {
            answerList.append(Int.random(in: 2...40))
        }
        answerList.append(correctAnswer)
        choiceArray = answerList.shuffled()
        isCorrectAnswer = false
        enabled = 0
        animationStates = [false, false ,false, false]
        correctAnswerShowing = false
        showCorrectAnswer = false
        isCorrect = false
        answers = 5
    }
    
    func answerIsCorrect(answer: Int, animation index : Int) {
        
        if answer == correctAnswer {
            isCorrectAnswer = true
            score += 1
            enabled += 360
            answers = index
            animationStates[index] = true
            isCorrect = true
        } else {
            score -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            showCorrectAnswer = true
            }
        }
    }
}

struct MultilplyByTwo_Previews: PreviewProvider {
    static var previews: some View {
        MultilplyByTwo()
    }
}
