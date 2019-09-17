//
//  TieBreakGame.swift
//  JeuSetMatch
//
//  Created by Graphic Influence on 17/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation
import UIKit

class TieBreakGame: Game {
    private static let scoreToReach = 7
    private var isTwoPointsAhead: Bool {
        return abs(scores[.one]! - scores[.two]!) >= 2
    }
    override func incrementScore(forPlayer player: Player) {
        scores[player]! += 1
        if scores[player]! >= TieBreakGame.scoreToReach && isTwoPointsAhead {
            end(withWinner: player)
        }
    }
}
