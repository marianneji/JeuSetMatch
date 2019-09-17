//
//  GameTestCase.swift
//  JeuSetMatchTests
//
//  Created by Graphic Influence on 03/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class GameTestCase: XCTestCase {

    var game: Game!

    override func setUp() {
        super.setUp()
        game = Game()
    }

    func setPlayer1Score(_ score: Int) {
        game.scores[.one] = score
    }

    func setPlayer2Score(_ score: Int) {
        game.scores[.two] = score
    }

    func testGIvenIsNull_WhenIncrementPlayer1Score_ThenScoreShouldBe15() {
        game.incrementScore(forPlayer: .one)

        XCTAssert(game.scores[.one]! == 15)
        XCTAssert(game.scores[.two]! == 0)
    }

    func testGivenScorePlayer1Is15_WhenIncrementPlayer1Score_ThenScoreShouldBe30() {
        setPlayer1Score(15)
        game.incrementScore(forPlayer: .one)

        XCTAssert(game.scores[.one]! == 30)
        XCTAssert(game.scores[.two]! == 0)
    }

    func testGivenScorePlayer1Is30_WhenIncrementPlayer1Score_ThenScoreShouldBe40() {
        setPlayer1Score(30)
        game.incrementScore(forPlayer: .one)

        XCTAssert(game.scores[.one]! == 40)
        XCTAssert(game.scores[.two]! == 0)
    }

    func testGivenPlayer1ScoreIs40_WhenIncrementPlayer1Score_ThenSetShouldBe1() {
        setPlayer1Score(40)
        game.incrementScore(forPlayer: .one)

        XCTAssertEqual(game.winner, .one)
        XCTAssertTrue(game.isOver)
    }
    func testGivenP1Is40AndP2Is30_WhenIncrementingP2Score_ThenScoreIs40To40() {
        setPlayer1Score(40)
        setPlayer2Score(30)

        game.incrementScore(forPlayer: .two)

        XCTAssertTrue(game.scoreIs40To40)
    }
}
