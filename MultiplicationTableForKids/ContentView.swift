//
//  ContentView.swift
//  MultiplicationTableForKids
//
//  Created by Vakhtang on 19.07.2023.
//

import SwiftUI

struct Item: Identifiable {
    
    let id = UUID()
    let title: String
    let image: String
    let multiplyNumber: Int
}

struct ContentView: View {
    
    let items = [
        Item(title: "Multiply", image: "1", multiplyNumber: 1),
        Item(title: "Multiply", image: "2", multiplyNumber: 2),
        Item(title: "Multiply", image: "3", multiplyNumber: 3),
        Item(title: "Multiply", image: "4", multiplyNumber: 4),
        Item(title: "Multiply", image: "5", multiplyNumber: 5),
        Item(title: "Multiply", image: "6", multiplyNumber: 6),
        Item(title: "Multiply", image: "7", multiplyNumber: 7),
        Item(title: "Multiply", image: "8", multiplyNumber: 8),
        Item(title: "Multiply", image: "9", multiplyNumber: 9)
    ]
    
    private let spacing: CGFloat = 10
    @State private var numberOfColumns = 3
    @State private var enabled = 0.0
    @State private var showAllInOne = false
    
    var body: some View {
        
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
        NavigationView {
            ScrollView {
                ZStack(alignment: .topTrailing) {
                    VStack {
                        headerView
                        LazyVGrid(columns: columns, spacing:  spacing) {
                            ForEach(items) { item in
                                NavigationLink(destination: MultiplyByOne(multiplyNumber: item.multiplyNumber).navigationBarHidden(true)) {
                                    ItemView(item: item)
                                }
                                .buttonStyle(ItemButtonStyle(cornerRudius: 20))
                            }
                        }
                        .padding(.horizontal)
                        .offset(y: -50)
                    }
                    
                    Button(action: {
                       showAllInOne = true
                    }) {
                        Image("test")
                            .resizable()
                            .frame(width: 80, height: 70)
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .padding(.trailing, 20)
                            .padding(.top, 35)
                    }
                    .fullScreenCover(isPresented: $showAllInOne) {
                        AllInOne()
                    }
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [
                Color(red: 255/255, green: 90/255, blue: 135/255),
                Color(red: 255/255, green: 202/255, blue: 58/255),
                Color(red: 69/255, green: 218/255, blue: 230/255),
                Color(red: 255/255, green: 90/255, blue: 135/255)
            ]), startPoint: .top, endPoint: .bottom))
            .ignoresSafeArea()
            
        }
        
        
    }
    var headerView: some View {
        
        return VStack {
            Image("tap")
                .resizable()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .onTapGesture {
                    withAnimation {
                        numberOfColumns = numberOfColumns % 3 + 1
                        enabled += 360
                    }
                    
                }
                .rotation3DEffect(.degrees(enabled), axis: (x: 0, y: 1, z: 0))
            
            Text("Multiplication table")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .medium, design: .rounded))
        }
        .frame(height: 310)
        .frame(maxWidth: .infinity)
        .background(Color.purple)
        
        
        
    }
    
    
}

struct ItemButtonStyle: ButtonStyle {
    
    
    let cornerRudius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        
        GeometryReader { reader in
            
            let fontSize = min(reader.size.width * 0.2, 20)
            let imageWidth: CGFloat = min(110, reader.size.width * 0.8)
            
            VStack(spacing: 1) {
                Text(item.title)
                    .font(.system(size: fontSize, weight: .medium, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
                
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth)
                
                
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
        }
        .frame(height: 130)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
