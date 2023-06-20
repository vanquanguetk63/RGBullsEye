//
//  ContentView.swift
//  RGBullsEye
//
//  Created by quang.tran4 on 20/06/2023.
//

import SwiftUI

struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1 - diff) * 100.0 + 0.5)
    }
    
    var body: some View {
        VStack {
            HStack {
              // Target color block
              VStack {
                  Rectangle().foregroundColor(Color(red: rTarget,green: gTarget, blue: bTarget, opacity: 1))
                Text("Match this color")
              }
              // Guess color block
              VStack {
                  Rectangle().foregroundColor(Color(red: rGuess,green: gGuess, blue: bGuess, opacity: 1))
                  HStack {
                      Text("R: \(Int(rGuess * 255.0))")
                      Text("G: \(Int(gGuess * 255.0))")
                      Text("B: \(Int(bGuess * 255.0))")
                }
              }
            }
            
            ColorChangeView(value: $rGuess,textColor: .red)
            ColorChangeView(value: $gGuess, textColor: .green)
            ColorChangeView(value: $bGuess,textColor:  .blue)
            Button(action: {
                self.showAlert = true
            }) {
                Text("Hit Me!")
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your Score"), message: Text("\(computeScore())"))
            }

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
    }
}

struct ColorChangeView: View {
    @Binding var value: Double
    var textColor: Color
    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
        }.padding()
    }
}
