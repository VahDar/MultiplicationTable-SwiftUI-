//
//  MultiplyByOne.swift
//  MultiplicationTableForKids
//
//  Created by Vakhtang on 22.07.2023.
//

import SwiftUI

struct MultiplyByOne: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var choiceArray = [0, 1, 2, 3]
    @State private var secondNumber = Int.random(in: 2...20)
    var multiplyNumber: Int
    @State private var correctAnswer = Int.random(in: 0...3)
    @State private var score = 0
    @State private var enabled = 0.0
    @State private var animationAmount = 1.0
    @State private var selectedAnswer: Int?
    @State private var answers: Int?
    @State private var animationStates = [false, false, false, false]
    @State private var isCorrectAnswer = false
    @State private var isCorrect = false
    @State private var correctAnswerShowing = false
    @State private var showCorrectAnswer = false
    @State private var isGameStarted = false
    
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 255/255, green: 255/255, blue: 153/255), // Yellow
                Color(red: 204/255, green: 255/255, blue: 204/255), // Light Green
                Color(red: 153/255, green: 204/255, blue: 255/255), // Sky Blue
                Color(red: 255/255, green: 204/255, blue: 153/255), // Orange
            ]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Button("Back") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 60, height: 30)
                    .foregroundColor(Color.white)
                    .background(
                        Color(red: 135/255, green: 206/255, blue: 235/255))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.leading, 16)
                    .padding(.top, 16)
                    Spacer()
                }
                if isGameStarted {
                    Text("\(multiplyNumber) x \(secondNumber)")
                        .foregroundColor(Color.black)
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
                                .opacity(index == answers && isCorrectAnswer ? 0 : 1)
                                .overlay(content: {
                                    if index == answers && isCorrectAnswer {
                                        Text("+ 1 score")
                                            .font(.system(size: 35))
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
                    .frame(width: 200, height: 80)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color(red: 255/255, green: 90/255, blue: 135/255), // Pink
                            Color(red: 255/255, green: 202/255, blue: 58/255), // Yellow
                            Color(red: 69/255, green: 218/255, blue: 230/255), // Cyan
                            Color(red: 255/255, green: 90/255, blue: 135/255), // Pink (same as the first color for seamless loop)
                        ]), startPoint: .top, endPoint: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 255/255, green: 90/255, blue: 135/255), lineWidth: 4) // Pink border
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
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .shadow(color: Color.black.opacity(0.6), radius: 10, y: 5)
                    Spacer()
                }
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
        
        let multiplyNumbers = multiplyNumber
        secondNumber = Int.random(in: 1...20)
        var answerList = [Int]()
        
        correctAnswer = multiplyNumbers * secondNumber
        for _ in 0...2 {
            answerList.append(Int.random(in: 1...180))
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

struct MultiplyByOne_Previews: PreviewProvider {
    static var previews: some View {
        MultiplyByOne(multiplyNumber: 1)
    }
}
