//
//  AdvantageGameTestCase.swift
//  JeuSetMatchTests
//
//  Created by Graphic Influence on 13/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class AdvantageGameTestCase: XCTestCase {
    var advantageGame: AdvantageGame!

    override func setUp() {
        super.setUp()
        advantageGame = AdvantageGame()

    }

    func testGivenInstanceOfAdavantageGame_WhenAccessingIt_ThenItExist() {
        XCTAssertNotNil(advantageGame)
    }

    func testGivenScoreIs0_WhenIncrementingScore_ThenScoreIs1() {

        advantageGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(advantageGame.scores[.one], 1)
    }

    func testGivenScorePlayer1Is1AndPlayer2Is0_WhenIncrementingPlayer2Score_ThenPlayersScoresIs0AndGameIsNotOver() {

        advantageGame.scores[.one] = 1
        advantageGame.scores[.two] = 0

        advantageGame.incrementScore(forPlayer: .two)

        XCTAssertFalse(advantageGame.isOver)
        XCTAssertEqual(advantageGame.scores[.one], 0)
        XCTAssertEqual(advantageGame.scores[.two], 0)
    }

    func testGivenScorePlayer1Is1AndPlayer2Is0_WhenIncrementingPlayer1Score_ThenPlayers1WinsAndGameIsOver() {

        advantageGame.scores[.one] = 1
        advantageGame.scores[.two] = 0

        advantageGame.incrementScore(forPlayer: .one)

        XCTAssertEqual(advantageGame.winner, .one)
        XCTAssertTrue(advantageGame.isOver)
    }
}
