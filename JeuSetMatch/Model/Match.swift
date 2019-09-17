//
//  Match.swift
//  Jeu Set & Match
//
//  Created by Ambroise COLLON on 19/10/2017.
//  Copyright © 2017 OpenClassrooms. All rights reserved.
//

import Foundation

class Match {
    // MARK: - Properties
    var sets = [Set()]

    var winner: Player? {
        return getWinner()
    }

    var isOver: Bool {
        return winner != nil
    }

    var scores: [Player: Int] {
        return getScores()
    }

    var currentGame: Game {
        return sets.last!.games.last!
    }

    var currentSet: Set {
        return sets.last!
    }

    let advantageGame = AdvantageGame()

    static let maxNumberOfWonSets = 3

    // MARK: - Private Getters
    private func getWinner() -> Player? {
        for (player, score) in scores where score == Match.maxNumberOfWonSets {
            return player
        }
        return nil
    }

    private func getScores() -> [Player: Int] {
        var scores = [Player.one: 0, Player.two: 0]

        for set in sets {
            if let setWinner = set.winner {
                scores[setWinner]! += 1
            }
        }
        return scores
    }

    // MARK: - Methods
    func pointEnded(wonBy player: Player) {
        if !isOver {
            currentGame.incrementScore(forPlayer: player)
            if currentGame.scoreIs40To40 {
                addAdvantageGameToCurrentGame()
            }
        }
        if currentGame.isOver {
            endCurrentGame()
        }
    }

    private func endCurrentGame() {
        if currentSet.isOver {
            addNewSetToMatch()
        } else {
            if currentSet.shouldGoToTieBreak {
                addTieBreakGameToCurrentSet()
            } else {
                addNewGameToCurrentSet()
            }
        }
    }

    fileprivate func addTieBreakGameToCurrentSet() {
        currentSet.games.append(TieBreakGame())
    }

    private func addAdvantageGameToCurrentGame() {
        currentSet.games.append(AdvantageGame())
    }

    private func addNewGameToCurrentSet() {
        currentSet.games.append(Game())
    }

    private func addNewSetToMatch() {
        sets.append(Set())
    }
}
