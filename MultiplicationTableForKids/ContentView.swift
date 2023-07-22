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
    let imgColor: Color
}

struct ContentView: View {
    
    let items = [
        Item(title: "Multiply", image: "1", imgColor: .mint),
        Item(title: "Multiply", image: "2", imgColor: .green),
        Item(title: "Multiply", image: "3", imgColor: .yellow),
        Item(title: "Multiply", image: "4", imgColor: .orange),
        Item(title: "Multiply", image: "5", imgColor: .pink),
        Item(title: "Multiply", image: "6", imgColor: .red),
        Item(title: "Multiply", image: "7", imgColor: .blue),
        Item(title: "Multiply", image: "8", imgColor: .indigo),
        Item(title: "Multiply", image: "9", imgColor: .brown),
        Item(title: "Multiply", image: "all", imgColor: .cyan)
    ]
    
    private let spacing: CGFloat = 10
    @State private var numberOfColumns = 3
    @State private var enabled = 0.0
    
    var body: some View {
        
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
        NavigationView {
            ScrollView {
                
                headerView
                
                LazyVGrid(columns: columns, spacing:  spacing) {
                    ForEach(items) { item in
                            NavigationLink(destination: destinationView(for: item)) {
                                ItemView(item: item)
                            }
                        .buttonStyle(ItemButtonStyle(cornerRudius: 20))
                    }
                }
                .padding(.horizontal)
                .offset(y: -50)
            }
            .background(Color.white)
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
        .frame(height: 350)
        .frame(maxWidth: .infinity)
        .background(Color.purple)
    }
    // Function to determine the destination view based on the selected item
       private func destinationView(for item: Item) -> some View {
           switch item.title {
           case "Multiply":
               switch item.image {
               case "1": return AnyView(MultiplyByOne())
               case "2": return AnyView(MultilplyByTwo())
               case "3": return AnyView(MultilplyByThree())
               case "4": return AnyView(MultilplyByFour())
               case "5": return AnyView(MultilplyByFive())
               case "6": return AnyView(MultilplyBySix())
               case "7": return AnyView(MultilplyBySeven())
               case "8": return AnyView(MultilplyByEignt())
               case "9": return AnyView(MultilplyByNine())
               case "all": return AnyView(AllInOne())
               // Add more cases as needed for other items
               default: return AnyView(EmptyView())
               }
           default:
               return AnyView(EmptyView()) // Fallback view for other items
           }
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
                    .foregroundColor(item.imgColor)
                    .frame(width: imageWidth)
                
                
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
