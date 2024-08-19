//
//  ContentView.swift
//  PaperRockScissors
//
//  Created by Tony Chang on 8/18/24.
//

import SwiftUI


struct ContentView: View {

    @State private var appChoice = Int.random(in: 0...2)
    @State private var playerWin = Bool.random()

    @State private var currentRound = 1
    @State private var playerScore = 0
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var gameOverTitle = ""
    @State private var showingGameOver = false

    let choices = [ "paper", "rock", "scissors" ]
    let numberOfRounds = 6

    @State private var rightChoice = 0

    var body: some View {

        let playerGoal = (playerWin) ? "win" : "lose"
        
        NavigationStack {
            VStack {

                Spacer()
                HStack {
                    Text("Current score: ")
                    Text("\(playerScore)")
                        .foregroundStyle(.blue)
                }

                HStack {
                    Text("The app chooses... ")
                    Text(choices[appChoice])
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Tap the choice to")
                    Text("\(playerGoal)")
                        .fontWeight(.heavy)
                        .foregroundColor((playerWin) ? .blue : .red)
                }

                Spacer()
                ForEach(0..<choices.count, id: \.self) { i in
                    Button("\(choices[i])") {
                        tapped(i)
                    }
                }

                Spacer()
                Spacer()
                Spacer()

            }
            .navigationTitle("PaperRockScissors")
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: nextRound)
            }
            .alert(gameOverTitle, isPresented: $showingGameOver) {
                Button("Continue", action: newGame)
            }
        }
    }
    
    func newGame() {
        playerScore = 0
        currentRound = 1
        playerWin.toggle()
        appChoice = Int.random(in: 0...2)
    }

    func nextRound() {
        playerWin.toggle()
        appChoice = Int.random(in: 0...2)
    }
    
    func tapped(_ number: Int) {
        // assign the target value based on values appChoice and playerWins
        switch appChoice {
        case 0:
            rightChoice = playerWin ? 2 : 1
            
        case 1:
            rightChoice = playerWin ? 0 : 2

        case 2:
            rightChoice = playerWin ? 1 : 0

        default:
            scoreTitle = "How did we end up here?"
            showingScore = true
        }

        if currentRound == numberOfRounds {
            playerScore += (number == rightChoice) ? 1 : 0
            gameOverTitle = "Game over! Final score: \(playerScore)"
            showingGameOver = true
        } else if number == rightChoice {
            playerScore += 1
            currentRound += 1
            scoreTitle = "Correct!"
            showingScore = true
        } else {
            scoreTitle = "Incorrect, the correct choice was \(choices[rightChoice])"
            showingScore = true
        }
    }
}

#Preview {
    ContentView()
}
