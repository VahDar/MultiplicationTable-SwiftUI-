//
//  AnswerButton.swift
//  MultiplicationTableForKids
//
//  Created by Vakhtang on 22.07.2023.
//

import SwiftUI

struct AnswerButton: View {
    var number: Int
    var body: some View {
        Text("\(number)")
            .frame(width: 200, height: 80)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .foregroundColor(.white)
            .font(.largeTitle)
            .shadow(color: Color.black.opacity(0.6), radius: 10, y: 5)
            
           
    }
}

struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AnswerButton(number: 100)
    }
}
