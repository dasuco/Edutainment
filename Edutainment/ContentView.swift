//
//  ContentView.swift
//  Edutainment
//
//  Created by Sucias Colomer, David on 19/7/21.
//

import SwiftUI

enum DificultOfGame {
    case easy
    case normal
    case hard
}

struct ContentView: View {
    
    private let numTables = [1,2,3,4,5,6,7,8,9,10]
    @State var tableOf: Int = 0
    
    @State var gameDificult: DificultOfGame = .normal
    @State var backgroundColorApp: Color = .white
    
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColorApp
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Spacer()
                        .frame(height: 24)
                    
                    Form {
                        Section(header: Text("Table Number")) {
                            Picker("Please choose table number: ", selection: $tableOf, content: {
                                ForEach(numTables, id: \.self) {
                                    Text("\($0)")
                                }
                            })
                        }
                        
                        Section(header: Text("Game Mode")) {
                            HStack {
                                DificultButton(dificultText: "Easy", dificultType: .easy).onTapGesture {
                                    gameDificult = .easy
                                    backgroundColorApp = addStyleAccordingGameMode()
                                }
                                
                                DificultButton(dificultText: "Normal", dificultType: .normal).onTapGesture {
                                    gameDificult = .normal
                                    backgroundColorApp = addStyleAccordingGameMode()
                                }
                                
                                DificultButton(dificultText: "Hard", dificultType: .hard).onTapGesture {
                                    gameDificult = .hard
                                    backgroundColorApp = addStyleAccordingGameMode()
                                }
                            }
                        }

                    }
                    .frame(height: 205)
                    
                    Spacer()
                        .frame(height: 24)
                    
                    // Game Field
                    
                    GameField(countQuestions: 2, questions: [
                        "10x3": [28, 30, 21],
                        "10x1": [20,10, 30]
                    ])
                    
                    Spacer()
                    
                }
                .navigationTitle(Text("Edutainment"))
            }
        }
    }
    
    func addStyleAccordingGameMode() -> Color {
        switch gameDificult {
        case .easy:
            return Color(red: 0, green: 0.75, blue: 0.5)
        case .normal:
            return Color(red: 1, green: 0.5, blue: 0)
        case .hard:
            return Color(red: 0.8, green: 0, blue: 0.2)
        }
    }
}

struct GameField: View {
    var countQuestions: Int
    var questions: [String: [Int]]
    @State var actualQuestion = 0
    @State var userCount = 0
    @State var showUserScoreView = false
    
    var body: some View {
        if showUserScoreView  {
            scoreView(userScore: userCount)
        } else {
            gameView()
        }
    }
    
    private func gameView() -> some View {
        let keys = questions.map{$0.key}
        let values = questions.map {$0.value}
        
        return VStack {
            HStack {
                Text("Game Field").padding(.leading)
                
                Spacer()
                
                Text("\(actualQuestion + 1) / \(countQuestions)").padding(.trailing)
            }
            
            Spacer()
                .frame(height: 24)
                
            Text("Choose correct answer to:  \(keys[actualQuestion])")
            
            Spacer()
                .frame(height: 24)
            
            HStack {
                Button("\(values[actualQuestion][0])") {
                    if isCorrectAnswer(op: keys[actualQuestion], value: values[actualQuestion][0]) {
                        userCount += 1
                    } else {
                        if userCount > 0 {
                            userCount -= 1
                        }
                    }
                    
                    if actualQuestion < countQuestions {
                        actualQuestion += 1
                        if actualQuestion == countQuestions {
                            showUserScoreView = true
                        }
                    }
                }
                .foregroundColor(.white)
                .frame(width: 80, height: 16)
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 0.7))
                .clipShape(Capsule())
                
                Button("\(values[actualQuestion][1])") {
                    if isCorrectAnswer(op: keys[actualQuestion], value: values[actualQuestion][1]) {
                        userCount += 1
                    } else {
                        if userCount > 0 {
                            userCount -= 1
                        }
                    }
                    
                    if actualQuestion < countQuestions {
                        actualQuestion += 1
                        if actualQuestion == countQuestions {
                            showUserScoreView = true
                        }
                    }
                    
                }
                .foregroundColor(.white)
                .frame(width: 80, height: 16)
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 0.7))
                .clipShape(Capsule())
                
                Button("\(values[actualQuestion][2])") {
                    if isCorrectAnswer(op: keys[actualQuestion], value: values[actualQuestion][2]) {
                        userCount += 1
                    } else {
                        if userCount > 0 {
                            userCount -= 1
                        }
                    }
                    
                    if actualQuestion < countQuestions {
                        actualQuestion += 1
                        if actualQuestion == countQuestions {
                            showUserScoreView = true
                        }
                    }
                }
                .foregroundColor(.white)
                .frame(width: 80, height: 16)
                .padding()
                .background(Color(red: 0, green: 0.5, blue: 0.7))
                .clipShape(Capsule())
            }
        }
    }
    
    private func scoreView(userScore: Int) -> some View {
        return VStack {
            Text("User Score \(userScore)")
        }
    }
    
    private func isCorrectAnswer(op: String, value: Int) -> Bool {
        let separateOp = op.components(separatedBy: "x")
        guard let firstValue = Int(separateOp[0]),
              let secondValue = Int(separateOp[1]) else {
            return false
        }
        
        let correctAnswer = (firstValue * secondValue) == value ? true : false
        return correctAnswer
    }
}

struct DificultButton: View {
    var dificultText: String
    var dificultType: DificultOfGame
    
    var body: some View {
        buildCustomButton()
    }
    
    @ViewBuilder
    private func buildCustomButton() -> some View {
        
        switch dificultType {
        case .easy:
            
            Text("Easy")
                .foregroundColor(.white)
                .bold()
                .frame(width: 80, height: 16)
                .padding()
                .background(Color(red: 0, green: 0.75, blue: 0.5))
                .clipShape(Capsule())
            
        case .normal:
            
            Text("Normal")
                .foregroundColor(.white)
                .bold()
                .frame(width: 80, height: 16)
                .padding()
                .background(Color(red: 1, green: 0.5, blue: 0))
                .clipShape(Capsule())
            
        case .hard:
            
            Text("Hard")
                .foregroundColor(.white)
                .bold()
                .frame(width: 80, height: 16)
                .padding()
                .background(Color(red: 0.8, green: 0, blue: 0.2))
                .clipShape(Capsule())
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
