//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Valera Sysov on 15.03.22.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "−"
    case divide = "÷"
    case mutlipy = "×"
    case equal = "="
    case clear = "C"
    case decimal = "."
    case precent = "%"
    case negative = "±"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutlipy, .divide, .equal:
            return .orange
        case .clear, .negative, .precent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
    
    func tag() -> Int {
        switch self {
            
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
            
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
            
        case .seven:
            return 7
            
        case .eight:
            return 8
        case .nine:
            return 9
        case .zero:
            return 0
        case .add:
            return 102
        case .subtract:
            return 103
        case .divide:
            return 101
        case .mutlipy:
            return 100
        case .equal:
            return 1000
        case .clear:
            return 1001
        case .decimal:
            return 1002
        case .precent:
            return 201
        case .negative:
            return 202
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    @ObservedObject var calculatorLogic: CalculatorLogic = CalculatorLogic()
    
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .precent, .divide],
        [.seven, .eight, .nine, .mutlipy],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        Text(calculatorLogic.displayText)
                            .font(.system(size: 100))
                            .foregroundColor(.white)
                        
                    }
                    .padding()
                    
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            
                            
                            ForEach(row, id: \.self) { item in
                                Button(action: {
                                    self.didTap(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame(width: self.buttonWidth(item: item, geometryReader: metrics),
                                               height: self.buttomHeight(geometryReader: metrics),
                                               alignment: .center)
                                        .background(item.buttonColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(self.buttonWidth(item: item, geometryReader: metrics)/2)
                                })
                            }
                        }
                        .padding(.bottom, 3)
                    }
                    
                }
                
            }
        }
    }
    func didTap(button: CalcButton) {
        let tag = button.tag()
        print("tapped button with tag \(tag)")
        if tag == 1000 {
            calculatorLogic.executeEqualOperand()
        } else if tag == 1001 {
            calculatorLogic.executeClear()
        } else if tag == 1002 {
            calculatorLogic.executeDecimal()
        } else if let binaryOperand = BinaryOperand(rawValue: tag) {
            calculatorLogic.executeBinaryOperand(binaryOperand: binaryOperand)
        } else if let unaryOperand = UnaryOperand(rawValue: tag) {
            calculatorLogic.executeUnaryOperand(unaryOperand: unaryOperand)
        } else {
            calculatorLogic.updateDisplayText(with: String(tag))
        }
    }
    
    func buttonWidth(item: CalcButton, geometryReader: GeometryProxy) -> CGFloat {
        if item == .zero {
            return (geometryReader.size.width - (4*12)) / 4 * 2
        }
        return (geometryReader.size.width - (5*12)) / 4
    }
    func buttomHeight(geometryReader: GeometryProxy) -> CGFloat {
        return (geometryReader.size.width - (5*12)) / 4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
