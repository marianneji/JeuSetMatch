//
//  AdvantageGame.swift
//  JeuSetMatch
//
//  Created by Graphic Influence on 17/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import UIKit

class AdvantageGame: Game {

    private let advantageWins = 2

    override func incrementScore(forPlayer player: Player) {
        scores[player]! += 1
        if let score = scores[player] {
            if scores[.one]! == scores[.two]! {
                scores[.one] = 0
                scores[.two] = 0
            } else if score == advantageWins {
                end(withWinner: player)
            }
        }
    }
}
