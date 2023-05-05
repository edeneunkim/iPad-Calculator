//
//  ContentView.swift
//  Calculator
//
//  Created by Eden Kim on 2023-04-22.
//

import SwiftUI

struct Colors {
    static let numButton = Color("NumButton")
    static let opButton = Color("OpButton")
    static let delButton = Color("DeleteButton")
    static let clearButton = Color("ClearButton")
    static let buttonFont = Color("ButtonFont")
    static let background = Color("Background")
    static let defaultButton = Color("DefaultButton")
}

enum CalculatorButton: String {
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
    case subtract = "-"
    case multiply = "×"
    case divide = "÷"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case delete = "⌫"
    case plusminus = "±"
    case lbracket = "("
    case rbracket = ")"
    case ln = "ln"
    case log2 = "log₂"
    case log = "log₁₀"
    case logx = "logₓ"
    case exp2 = "x²"
    case exp3 = "x³"
    case exp = "xʸ"
    case eexp = "eˣ"
    case tenexp = "10ˣ"
    case inv = "1/x"
    case root = "√"
    case croot = "³√"
    case yroot = "ʸ√"
    case factorial = "!"
    case abs = "abs"
    case sin = "sin"
    case cos = "cos"
    case tan = "tan"
    case e = "e"
    case sec = "sec"
    case csc = "csc"
    case cot = "cot"
    case pi = "π"
    
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .percent, .plusminus:
            return Colors.opButton
        case .clear:
            return Colors.clearButton
        case .delete:
            return Colors.delButton
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal, .equal:
            return Colors.numButton
        default:
            return Colors.defaultButton
        }
    }
}

    
struct ContentView: View {
    
    @State var value = ""
    @State var ans = ""
    @State var currNum = 0
    
    let buttons: [[CalculatorButton]] = [
        [.exp2, .exp3, .exp, .lbracket, .rbracket, .clear, .plusminus, .percent, .divide],
        [.ln, .log2, .log, .logx, .eexp, .seven, .eight, .nine, .multiply],
        [.inv, .root, .croot, .yroot, .factorial, .four, .five, .six, .subtract],
        [.abs, .sin, .cos, .tan, .e, .one, .two, .three, .add],
        [.tenexp, .csc, .sec, .cot, .pi, .zero, .decimal, .equal, .delete]
    ]
    
    var body: some View {
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 80))
                        .foregroundColor(Colors.buttonFont)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Text(ans)
                        .bold()
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 20) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.tapped(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item:
                                            item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(Colors.buttonFont)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 0.25)
                }
            }
        }
    }
    
    func tapped(button: CalculatorButton) {
        switch button {
        case .equal:
            equalTap()
        case .delete:
            if (!value.isEmpty) {
                value.removeLast()
            }
        case .clear:
            value = ""
        case .plusminus:
            if (value[value.startIndex] != "-") {
                value = "-" + value
            } else {
                value.removeFirst()
            }
        case .exp, .exp2, .exp3, .ln, .log2, .log, .logx, .eexp, .inv, .abs, .sin, .cos, .tan, .tenexp, .csc, .sec, .cot:
            specialOp()
        default:
            let number = button.rawValue
            value = value + String(number)
        }
    }
    
    func equalTap() {
        
    }
    
    func specialOp() {
        
    }
    
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 130)) / 5
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 130)) / 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
