//
//  SetTestCase.swift
//  JeuSetMatchTests
//
//  Created by Graphic Influence on 03/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class SetTestCase: XCTestCase {

    var set: Set!

    override func setUp() {
       super.setUp()
        set = Set()
    }

    func createManyGames( _ count: Int, winBy player: Player) {
        for _ in 1...count {
            let game = Game()
            game.winner = player
            set.games.append(game)
        }
    }

    func testGivenPlayerWins2To3_WhenGettingScoreFromSet_ThenScoreShouldBe3To2() {

        createManyGames(2, winBy: .one)
        createManyGames(3, winBy: .two)

        XCTAssertEqual(set.scores[.one], 2)
        XCTAssertEqual(set.scores[.two], 3)
    }

    func testGivenSetIsNotOver_WhenGettingWinner_ThenWinnerIsNil() {

        XCTAssertNil(set.winner)
    }

    func testGivenPlayer1HasWon6Games_WhenGettingWinner_ThenPlayer1ShouldBeWinner() {

        createManyGames(6, winBy: .one)

        XCTAssertEqual(set.winner, .one)
        XCTAssertEqual(set.isOver, true)
    }

    func testGivenScoreIs6to5_WhenGettingWinner_ThenNoWinnerAndSetIsNotOver() {

        createManyGames(6, winBy: .one)
        createManyGames(5, winBy: .two)

        XCTAssertNil(set.winner)
        XCTAssertFalse(set.isOver)
    }

    func testGivenScoreIs7To6_WhenGettingWinner_ThenPlayer1Wins() {

        createManyGames(7, winBy: .one)
        createManyGames(6, winBy: .two)

        XCTAssertEqual(set.winner, .one)
        XCTAssertTrue(set.isOver)
    }
}
