# iPad-Calculator
A calculator app programmed and designed specifically for the iPad.
## Introduction
This is a calculator app for iPad that I am making as a personal project to learn how to use Swift and XCode to make iOS apps. Since the iPad does not have a dedicated calculator app, I thought that making a calculator for the iPad would be a fun and useful way for me to learn Swift while creating an important app missing on the iPad. I thought that a calculator would look and function better when used in landscape mode, so I have locked the calculator app to display in landscape mode only. 
## Technologies
Swift
iOS 16.4
## How to Use
The output will appear on the calculator screen according to the buttons pressed. This calculator app works similar to any other calculator, where the user inputs a mathematical expression by pressing the buttons then pressing equals, which outputs the answer. Most of the complex expressions (buttons colored darker grey on the left) can be calculated by inputting the number first, then pressing the complex expression. However, the expressions involving two numbers, such as xʸ and ʸ√ require the user to input the x number first, then the y number. The following are example uses:
* User presses 7, then presses +, then presses 9. The top part of the screen shows "7 + 9" with "16" showing right below in a smaller font. The user presses the equals button, which causes the top part of the screen to show 16
* User presses 5, then presses x³, which shows 125. The user then presses ⌫, which then deletes x³
* User presses 3, then presses xʸ, then presses 4, which shows 81
* User presses 6, then presses ʸ√, then presses 216, which shows 3
## Files
Most of the code is in the ContentView file in the Calculator package. The custom colors that I created are in the Assets file. 
To view images of the calculator in use, you can check the Screenshots folder.
## Sources
I used the following videos as a guideline to learn how to code a calculator with Swift:
* https://www.youtube.com/watch?v=A2gGNTKo_q8
* https://www.youtube.com/watch?v=cMde7jhQlZI
