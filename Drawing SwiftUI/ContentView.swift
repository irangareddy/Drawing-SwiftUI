//
//  ContentView.swift
//  Drawing SwiftUI
//
//  Created by RANGA REDDY NUKALA on 13/09/20.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }.drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
           var targetHue = Double(value) / Double(self.steps) + self.amount

           if targetHue > 1 {
               targetHue -= 1
           }

           return Color(hue: targetHue, saturation: 1, brightness: brightness)
       }
    
}

struct ContentView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct FlowerView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 50.0
    
    var body: some View {
        VStack {
            
            // MARK:- CGAffineTransform

            
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal,.bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
            
            // MARK:- ImagePaint

            
            Text("Ranga Reddy")
                .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border(ImagePaint(image: Image("AbstractShapes"), sourceRect: CGRect(x: 0, y: 0.3, width: 1, height: 0.5),scale: 0.1),width: 30)
        }
    }
}
