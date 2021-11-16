//
//  ManualLayoutCalculatorViewController.swift
//  Calculator
//
//  Created by Nickolai Nikishin on 13.11.21.
//

import UIKit

class ManualLayoutCalculatorViewController: AbstractCalculatorViewController {
    
    override var displayLabel: UILabel! {
        set {
            
        }
        
        get {
            return manualDisplayLabel
        }
    }
    
    let manualDisplayLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        createUI()
    }
    
    func createUI() {
        addButtons()
    }
    
    func addButtons() {
        let equalButton = BinaryOperatorButton(type: .custom)
        equalButton.addTarget(self, action: #selector(equalOperatorButtonTapped), for: .touchUpInside)
        equalButton.setTitle("=", for: .normal)
        equalButton.setTitleColor(equalButton.selectedColor, for: .normal)
        equalButton.setTitleColor(equalButton.defaultColor, for: .selected)
        equalButton.backgroundColor = equalButton.defaultColor
        equalButton.titleLabel?.font = UIFont.systemFont(ofSize: 46, weight: .semibold)
        
        equalButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(equalButton)
        
        NSLayoutConstraint.activate([
            equalButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            equalButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            equalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            equalButton.heightAnchor.constraint(equalTo: equalButton.widthAnchor)
        ])
        
        let decimalSeparatorButton = DigitButton(type: .custom)
        decimalSeparatorButton.addTarget(self, action: #selector(decimalSeparatorButtonTapped), for: .touchUpInside)
        decimalSeparatorButton.setTitle(CalculatorLogic.formatter.decimalSeparator, for: .normal)
        decimalSeparatorButton.setTitleColor(DigitButton.defaultTextColor, for: .normal)
        decimalSeparatorButton.backgroundColor = DigitButton.defaultBackgroundColor
        decimalSeparatorButton.titleLabel?.font = DigitButton.font
        decimalSeparatorButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(decimalSeparatorButton)
        
        NSLayoutConstraint.activate([
            decimalSeparatorButton.trailingAnchor.constraint(equalTo: equalButton.leadingAnchor, constant: -20),
            decimalSeparatorButton.bottomAnchor.constraint(equalTo: equalButton.bottomAnchor),
            decimalSeparatorButton.widthAnchor.constraint(equalTo: equalButton.widthAnchor),
            decimalSeparatorButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let digit0Button = DigitButton.generate(title: "0")
        digit0Button.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(digit0Button)
        
        NSLayoutConstraint.activate([
            digit0Button.trailingAnchor.constraint(equalTo: decimalSeparatorButton.leadingAnchor, constant: -20),
            digit0Button.bottomAnchor.constraint(equalTo: equalButton.bottomAnchor),
            digit0Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            digit0Button.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let sumButton = BinaryOperatorButton(type: .custom)
        sumButton.tag = BinaryOperand.sum.rawValue
        sumButton.addTarget(self, action: #selector(binaryOperandButtonTapped), for: .touchUpInside)
        sumButton.setTitle("+", for: .normal)
        sumButton.setTitleColor(sumButton.selectedColor, for: .normal)
        sumButton.setTitleColor(sumButton.defaultColor, for: .selected)
        sumButton.backgroundColor = sumButton.defaultColor
        sumButton.titleLabel?.font = UIFont.systemFont(ofSize: 46, weight: .semibold)
        
        sumButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(sumButton)
        
        NSLayoutConstraint.activate([
            sumButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sumButton.bottomAnchor.constraint(equalTo: equalButton.topAnchor, constant: -20),
            sumButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            sumButton.heightAnchor.constraint(equalTo: equalButton.widthAnchor)
        ])
        
        let minusButton = BinaryOperatorButton(type: .custom)
        minusButton.tag = BinaryOperand.substruct.rawValue
        minusButton.addTarget(self, action: #selector(binaryOperandButtonTapped), for: .touchUpInside)
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(minusButton.selectedColor, for: .normal)
        minusButton.setTitleColor(minusButton.defaultColor, for: .selected)
        minusButton.backgroundColor = minusButton.defaultColor
        minusButton.titleLabel?.font = UIFont.systemFont(ofSize: 46, weight: .semibold)
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(minusButton)
        
        NSLayoutConstraint.activate([
            minusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            minusButton.bottomAnchor.constraint(equalTo: sumButton.topAnchor, constant: -20),
            minusButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            minusButton.heightAnchor.constraint(equalTo: equalButton.widthAnchor)
        ])
        let multiplyButton = BinaryOperatorButton(type: .custom)
        multiplyButton.tag = BinaryOperand.multiply.rawValue
        multiplyButton.addTarget(self, action: #selector(binaryOperandButtonTapped), for: .touchUpInside)
        multiplyButton.setTitle("x", for: .normal)
        multiplyButton.setTitleColor(multiplyButton.selectedColor, for: .normal)
        multiplyButton.setTitleColor(multiplyButton.defaultColor, for: .selected)
        multiplyButton.backgroundColor = multiplyButton.defaultColor
        multiplyButton.titleLabel?.font = UIFont.systemFont(ofSize: 46, weight: .semibold)
        
        multiplyButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(multiplyButton)
        
        NSLayoutConstraint.activate([
            multiplyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            multiplyButton.bottomAnchor.constraint(equalTo: minusButton.topAnchor, constant: -20),
            multiplyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            multiplyButton.heightAnchor.constraint(equalTo: equalButton.widthAnchor)
        ])
        
        let divideButton = BinaryOperatorButton(type: .custom)
        divideButton.tag = BinaryOperand.divide.rawValue
        divideButton.addTarget(self, action: #selector(binaryOperandButtonTapped), for: .touchUpInside)
        divideButton.setTitle("÷", for: .normal)
        divideButton.setTitleColor(divideButton.selectedColor, for: .normal)
        divideButton.setTitleColor(divideButton.defaultColor, for: .selected)
        divideButton.backgroundColor = divideButton.defaultColor
        divideButton.titleLabel?.font = UIFont.systemFont(ofSize: 46, weight: .semibold)
        
        divideButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(divideButton)
        
        NSLayoutConstraint.activate([
            divideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            divideButton.bottomAnchor.constraint(equalTo: multiplyButton.topAnchor, constant: -20),
            divideButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            divideButton.heightAnchor.constraint(equalTo: equalButton.widthAnchor)
        ])
        
        manualDisplayLabel.font = UIFont.systemFont(ofSize: 70)
        manualDisplayLabel.textAlignment = .right
        manualDisplayLabel.textColor = .white
        manualDisplayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(manualDisplayLabel)
        
        NSLayoutConstraint.activate([
            manualDisplayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            manualDisplayLabel.bottomAnchor.constraint(equalTo: divideButton.topAnchor, constant: -20),
            manualDisplayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        let threeButton = DigitButton.generate(title: "3")
        threeButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(threeButton)
        
        NSLayoutConstraint.activate([
            threeButton.trailingAnchor.constraint(equalTo: sumButton.leadingAnchor, constant: -20),
            threeButton.bottomAnchor.constraint(equalTo: decimalSeparatorButton.topAnchor, constant: -20),
            threeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            threeButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        let sixButton = DigitButton.generate(title: "6")
        sixButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(sixButton)
        
        NSLayoutConstraint.activate([
            sixButton.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor, constant: -20),
            sixButton.bottomAnchor.constraint(equalTo: threeButton.topAnchor, constant: -20),
            sixButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            sixButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        let nineButton = DigitButton.generate(title: "9")
        nineButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(nineButton)
        
        NSLayoutConstraint.activate([
            nineButton.trailingAnchor.constraint(equalTo: multiplyButton.leadingAnchor, constant: -20),
            nineButton.bottomAnchor.constraint(equalTo: sixButton.topAnchor, constant: -20),
            nineButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            nineButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let percentButton = UnaryOperatorButton(type: .custom)
        percentButton.tag = UnaryOperand.percent.rawValue
        percentButton.addTarget(self, action: #selector(unaryOperatorButtonTapped), for: .touchUpInside)
        percentButton.setTitle("%", for: .normal)
        percentButton.setTitleColor(percentButton.selectedColor, for: .normal)
      
        percentButton.backgroundColor = percentButton.defaultColor
        percentButton.titleLabel?.font = UIFont.systemFont(ofSize: 46, weight: .semibold)
        
        percentButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(percentButton)
        
        NSLayoutConstraint.activate([
            percentButton.trailingAnchor.constraint(equalTo: divideButton.leadingAnchor, constant: -20),
            percentButton.bottomAnchor.constraint(equalTo: nineButton.topAnchor, constant: -20),
            percentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            percentButton.heightAnchor.constraint(equalTo: equalButton.widthAnchor)
        ])
        
        let twoButton = DigitButton.generate(title: "2")
        twoButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(twoButton)
        
        NSLayoutConstraint.activate([
            twoButton.trailingAnchor.constraint(equalTo: threeButton.leadingAnchor, constant: -20),
            twoButton.bottomAnchor.constraint(equalTo: digit0Button.topAnchor, constant: -20),
            twoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            twoButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let fiveButton = DigitButton.generate(title: "5")
        fiveButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(fiveButton)
        
        NSLayoutConstraint.activate([
            fiveButton.trailingAnchor.constraint(equalTo: sixButton.leadingAnchor, constant: -20),
            fiveButton.bottomAnchor.constraint(equalTo: twoButton.topAnchor, constant: -20),
            fiveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            fiveButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let eightButton = DigitButton.generate(title: "8")
        eightButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(eightButton)
        
        NSLayoutConstraint.activate([
            eightButton.trailingAnchor.constraint(equalTo: nineButton.leadingAnchor, constant: -20),
            eightButton.bottomAnchor.constraint(equalTo: fiveButton.topAnchor, constant: -20),
            eightButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            eightButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let plusMinusButton = UnaryOperatorButton(type: .custom)
        plusMinusButton.tag = UnaryOperand.invert.rawValue
        plusMinusButton.addTarget(self, action: #selector(unaryOperatorButtonTapped), for: .touchUpInside)
        plusMinusButton.setTitle("±", for: .normal)
        plusMinusButton.setTitleColor(plusMinusButton.selectedColor, for: .normal)
        plusMinusButton.backgroundColor = plusMinusButton.defaultColor
        plusMinusButton.titleLabel?.font = UIFont.systemFont(ofSize: 46, weight: .semibold)
        
        plusMinusButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(plusMinusButton)
        
        NSLayoutConstraint.activate([
            plusMinusButton.trailingAnchor.constraint(equalTo: percentButton.leadingAnchor, constant: -20),
            plusMinusButton.bottomAnchor.constraint(equalTo: eightButton.topAnchor, constant: -20),
            plusMinusButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            plusMinusButton.heightAnchor.constraint(equalTo: equalButton.widthAnchor)
        ])
        
        let oneButton = DigitButton.generate(title: "1")
        oneButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(oneButton)
        
        NSLayoutConstraint.activate([
            oneButton.trailingAnchor.constraint(equalTo: twoButton.leadingAnchor, constant: -20),
            oneButton.bottomAnchor.constraint(equalTo: digit0Button.topAnchor, constant: -20),
            oneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            oneButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let fourButton = DigitButton.generate(title: "4")
        fourButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(fourButton)
        
        NSLayoutConstraint.activate([
            fourButton.trailingAnchor.constraint(equalTo: fiveButton.leadingAnchor, constant: -20),
            fourButton.bottomAnchor.constraint(equalTo: oneButton.topAnchor, constant: -20),
            fourButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            fourButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let sevenButton = DigitButton.generate(title: "7")
        fourButton.addTarget(self, action: #selector(digitButtonTapped), for: .touchUpInside)
        
        view.addSubview(sevenButton)
        
        NSLayoutConstraint.activate([
            sevenButton.trailingAnchor.constraint(equalTo: eightButton.leadingAnchor, constant: -20),
            sevenButton.bottomAnchor.constraint(equalTo: fourButton.topAnchor, constant: -20),
            sevenButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            sevenButton.heightAnchor.constraint(equalTo: equalButton.heightAnchor)
        ])
        
        let clearButton = UnaryOperatorButton(type: .custom)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        clearButton.setTitle("AC", for: .normal)
        clearButton.setTitleColor(clearButton.selectedColor, for: .normal)
        clearButton.backgroundColor = clearButton.defaultColor
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 46, weight: .semibold)
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(clearButton)
        
        NSLayoutConstraint.activate([
            clearButton.trailingAnchor.constraint(equalTo: plusMinusButton.leadingAnchor, constant: -20),
            clearButton.bottomAnchor.constraint(equalTo: sevenButton.topAnchor, constant: -20),
            clearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25, constant: -25),
            clearButton.heightAnchor.constraint(equalTo: equalButton.widthAnchor)
        ])
    }
}
