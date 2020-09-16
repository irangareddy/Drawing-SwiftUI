//
//  ContentView.swift
//  Drawing SwiftUI
//
//  Created by RANGA REDDY NUKALA on 13/09/20.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink(
                        destination: BasicShapesView()) {
                        Text("Basic Shapes")
                    }
                    NavigationLink(
                        destination: FlowerView()) {
                        Text("Flower")
                    }
                    NavigationLink(
                        destination: ImagePaintView()) {
                        Text("Image as Border")
                    }
                    NavigationLink(
                        destination: ColorCycleView()) {
                        Text("Color Circle")
                    }
                    NavigationLink(
                        destination: EditImageView()) {
                        Text("Edit Image")
                    }
                    
                    NavigationLink(
                        destination: TrapezoidView()) {
                        Text("Trapezoid with Animation")
                    }
                    NavigationLink(
                        destination: CheckBoardView()) {
                        Text("Check Board")
                    }
                }
            }.navigationBarTitle("Drawing")
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

            
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal,.bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
            
        }
    }
}


struct ImagePaintView: View {
    
    var body: some View {
        VStack {

            
            Text("Ranga Reddy")
                .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border(ImagePaint(image: Image("AbstractShapes"), sourceRect: CGRect(x: 0, y: 0.3, width: 1, height: 0.5),scale: 0.1),width: 30)
        }
    }
}
struct BasicShapesView: View {

    var body: some View {
        Form {
            Section(header: Text("Triangle")) {
                Triangle()
                    .frame(width: 150, height: 100, alignment: .center)
                    .foregroundColor(.orange)
            }
            Section(header: Text("Arc / Progress Bar")) {
            Arc(startAngle: .degrees(0), endAngle: .degrees(240), clockwise: true)
                .strokeBorder(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),Color.purple]), startPoint: .leading, endPoint: .trailing),style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.pink)
                .padding()
            }
            
            Section(header: Text("Infinite Loop with Trim")) {
            Infinite()
                .trim(from: 0, to: 0.5)
                .scale(50, anchor: .topLeading)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.red,Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            Section(header: Text("Infinite Loop without Trim")) {
            Infinite()
                .trim(from: 0, to: 1)
                .scale(50, anchor: .topLeading)
                .stroke(Color.green, lineWidth: 10)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
        }
    }
}


struct ColorCycleView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            Spacer()
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            Spacer()
            Text("Slide Colors here")
            Slider(value: $colorCycle)
                .padding([.vertical,.horizontal],20)
            Spacer()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EditImageView: View {
    @State private var blurAmount: CGFloat = 0.1
    @State private var saturationAmount: CGFloat = 0.3

    var body: some View {
        VStack {
            Image("Ranga")
                .resizable()
                .scaledToFit()
                .frame(width: 300, alignment: .center)
                .saturation(Double(saturationAmount))
                .blur(radius: (blurAmount)*20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
                    )
                                ).clipped()
            VStack(alignment: .leading, spacing: 10){
                Text("Blur").padding([.top,.leading])
                Slider(value: $blurAmount)
                    .padding(.horizontal)
                Text("Saturation").padding([.top,.leading])
                Slider(value: $saturationAmount)
                    .padding(.horizontal)
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

struct TrapezoidView: View {
    @State private var insetAmount: CGFloat = 50.0
    
    var body: some View {
        VStack {
            Trapezoid(insetAmount: insetAmount)
                .frame(width: 300, height: 400, alignment: .center)
                .foregroundColor(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
                .onTapGesture{
                    withAnimation {
                            self.insetAmount = CGFloat.random(in: 10...90)
                        }
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}


struct CheckBoardView: View {
    @State private var rows = 4
    @State private var columns = 4

    var body: some View {
        VStack {
            Checkboard(rows: rows, columns: columns)
                .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border(Color.black, width: 3)
                .onTapGesture {
                    withAnimation(.linear(duration: 3)) {
                        self.rows = 8
                        self.columns = 8
                    }
                    
            
                    
            }.navigationBarTitleDisplayMode(.inline)
            
            HStack {
                Text("Rows \(rows)")
                Text("Columns \(columns)")
            }.padding()
        }
    }
}
