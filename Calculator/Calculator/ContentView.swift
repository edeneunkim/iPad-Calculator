//
//  ContentView.swift
//  Calculator
//
//  Created by Eden Kim on 2023-04-22.
//

import SwiftUI

struct numStack {
    var items: [String] = []
    
    func peek() -> String {
        guard let topElement = items.first else { fatalError("Stack empty")}
        return topElement
    }
    
    mutating func pop() -> String {
        return items.removeFirst()
    }

    mutating func push(element: String) {
        items.insert(element, at: 0)
    }
    
    mutating func update(element: String) {
        items[0] = element
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    mutating func clear() {
        items.removeAll()
    }
}

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
    case arcsin = "sin\u{207B}\u{00B9}"
    case arccos  = "cos\u{207B}\u{00B9}"
    case arctan = "tan\u{207B}\u{00B9}"
    case pi = "π"
    
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .percent:
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
    
    @State var output = ""
    @State var ans = ""
    @State var currNum = ""
    @State var numsOps = numStack()
    @State var nums = numStack()
    @State var eValue = exp(1.0)
    @State var piValue = Double.pi
    
    let buttons: [[CalculatorButton]] = [
        [.exp2, .exp3, .exp, .lbracket, .rbracket, .clear, .percent, .divide],
        [.ln, .log2, .log, .logx, .eexp, .seven, .eight, .nine, .multiply],
        [.inv, .root, .croot, .yroot, .factorial, .four, .five, .six, .subtract],
        [.abs, .sin, .cos, .tan, .e, .one, .two, .three, .add],
        [.tenexp, .arcsin, .arccos, .arctan, .pi, .zero, .decimal, .equal, .delete]
    ]
    
    var body: some View {
        ZStack {
            Colors.background.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(output)
                        .bold()
                        .font(.system(size: 64))
                        .foregroundColor(Colors.buttonFont)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Text(ans)
                        .bold()
                        .font(.system(size: 40))
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
            if (numsOps.isEmpty() || numsOps.peek() == "+" || numsOps.peek() == "-" || numsOps.peek() == "*" || numsOps.peek() == "/") {
                break
            }
            calculate()
            equalTap()
        case .delete:
            deleteTap()
        case .clear:
            clearTap()
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal, .pi, .e:
            numTap(button: button)
        case .divide, .multiply, .subtract, .add, .lbracket, .rbracket:
            opTap(button: button)
        default:
            if (numsOps.isEmpty() || numsOps.peek() == "+" || numsOps.peek() == "-" || numsOps.peek() == "*" || numsOps.peek() == "/") {
                break
            } else {
                specialOperation(op: button)
            }
        }
    }
    
    func equalTap() {
        output = ans
        ans = ""
        numsOps.clear()
        nums.clear()
        currNum = output
        numsOps.push(element: currNum)
        nums.push(element: currNum)
    }
    
    func calculate() {
        var expression = ""
        for numOp in numsOps.items.reversed() {
            if (numOp == "+" || numOp == "-" || numOp == "*" || numOp == "/") {
                expression = expression + numOp
            } else {
                expression = expression + String(Double(numOp) ?? 0)
            }
        }
        print(expression)
        let result = NSExpression(format: expression)
        ans = String(result.expressionValue(with: nil, context: nil) as! Double)
        ans = formatNum(num: Double(ans) ?? 0)
    }
    
    func deleteTap() {
        if (numsOps.isEmpty()) {
            return
        }
        if (numsOps.peek() == "+" || numsOps.peek() == "-" || numsOps.peek() == "*" || numsOps.peek() == "/") {
            _ = numsOps.pop()
            output.removeLast()
        } else {
            currNum.removeLast()
            output.removeLast()
            if (currNum == "") {
                _ = numsOps.pop()
                _ = nums.pop()
                if (nums.isEmpty()) {
                    currNum = ""
                } else {
                    currNum = nums.peek()
                }
            } else {
                numsOps.update(element: currNum)
                nums.update(element: currNum)
            }
        }
        ans = ""
    }
    
    func clearTap() {
        output = ""
        ans = ""
        currNum = ""
        numsOps.clear()
        nums.clear()
    }

    func numTap(button: CalculatorButton) {
        var pressed = button.rawValue
        if (numsOps.isEmpty() || numsOps.peek() == "+" || numsOps.peek() == "-" || numsOps.peek() == "*" || numsOps.peek() == "/") {
            output = output + pressed
            if (pressed == "π") {
                pressed = String(piValue)
            } else if (pressed == "e") {
                pressed = String(eValue)
            }
            currNum = pressed
            numsOps.push(element: currNum)
            nums.push(element: currNum)
            calculate()
        } else {
            if (pressed == ".") {
                if (!currNum.contains(".")) {
                    currNum = currNum + pressed
                    output = output + pressed
                }
            } else {
                output = output + pressed
                if (pressed == "π") {
                    pressed = String(piValue)
                } else if (pressed == "e") {
                    pressed = String(eValue)
                }
                currNum = currNum + pressed
            }
            if (numsOps.isEmpty()) {
                numsOps.push(element: currNum)
                nums.push(element: currNum)
            } else {
                numsOps.update(element: currNum)
                nums.update(element: currNum)
            }
        }
    }
    
    func opTap(button: CalculatorButton) {
        let pressed = button.rawValue
        if (output == "" && (pressed == "+" || pressed == "*" || pressed == "/")) {
            return
        }
        output = output + pressed
        if (pressed == "+") {
            numsOps.push(element: "+")
        } else if (pressed == "-") {
            numsOps.push(element: "-")
        } else if (pressed == "×") {
            numsOps.push(element: "*")
        } else if (pressed == "÷") {
            numsOps.push(element: "/")
        }
    }
    
    
    func specialOperation(op: CalculatorButton) {
        var num = Double(currNum) ?? 0
        switch op {
        case .exp2:
            num = pow(num, 2)
        case .exp3:
            num = pow(num, 3)
        case .ln:
            if (num <= 0) {
                break
            }
            num = log(num)
        case .log2:
            if (num <= 0) {
                break
            }
            num = log2(num)
        case .log:
            if (num <= 0) {
                break
            }
            num = log10(num)
        case .eexp:
            num = pow(eValue, num)
        case .inv:
            if (num == 0) {
                break
            }
            num = pow(num, -1)
        case .root:
            if (num < 0) {
                break
            }
            num = sqrt(num)
        case .croot:
            num = cbrt(num)
        case .factorial:
            if (num.truncatingRemainder(dividingBy: 1) == 0) {
                num = factorialFunc(number: Int(num))
            }
        case .abs:
            num = abs(num)
        case .sin:
            num = sin(num)
        case .cos:
            num = cos(num)
        case .tan:
            num = tan(num)
        case .tenexp:
            num = pow(10, num)
        case .arcsin:
            if (num > 1 || num < -1) {
                break
            }
            num = asin(num)
        case .arccos:
            if (num > 1 || num < -1) {
                break
            }
            num = acos(num)
        case .arctan:
            num = atan(num)
        default:
            break
        }
        let result = formatNum(num: num)
        numsOps.update(element: result)
        nums.update(element: result)
        output = String(output.dropLast(currNum.count))
        currNum = result
        output = output + result
        calculate()
    }
    
    func factorialFunc(number: Int) -> Double {
        var result = 1
        if (number > 1) {
            for i in 1...number {
                result *= i
            }
        }
        return Double(result)
    }
    
    func formatNum(num: Double) -> String {
        let intNum = String(Int(num))
        let doubleNum = String(num)
        let decimalDigits = doubleNum.count - intNum.count
        if (num.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", num)
        } else if (decimalDigits >= 6) {
            return String(format: "%.6f", num)
        }
        return String(num)
    }
    
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        if (item == .clear) {
            return (UIScreen.main.bounds.width - (2 * 130)) / 4
        }
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
