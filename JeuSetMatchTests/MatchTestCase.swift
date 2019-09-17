//
//  MatchTestCase.swift
//  JeuSetMatchTests
//
//  Created by Graphic Influence on 03/09/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import XCTest
@testable import JeuSetMatch

class MatchTestCase: XCTestCase {

    var match: Match!

    override func setUp() {
        super.setUp()
        match = Match()
    }

    // MARK: - Helpers
    private func createSet(wonByPlayer player: Player) -> JeuSetMatch.Set {
        let set = Set()
        createManyGames(6, wonByPlayer: player, inSet: set)
        return set
    }

    private func createManyGames(_ count: Int, wonByPlayer player: Player, inSet set: JeuSetMatch.Set) {
        for _ in 1...count {
            let game = Game()
            game.winner = player
            set.games.append(game)
        }
    }

    private func createManySets(_ count: Int, wonByPlayer player: Player) {
        for _ in 1...count {
            let set = createSet(wonByPlayer: player)
            match.sets.append(set)
        }
    }

    // MARK: - Tests
    func testGivenPlayerOneHasWonThreeSets_WhenGettingWinner_ThenWinnerShouldBePlayerOneAndGameIsOver() {

        createManySets(3, wonByPlayer: .one)

        XCTAssertEqual(match.winner, .one)
        XCTAssertEqual(match.isOver, true)
    }

    func testGivenMatchIsOver_WhenPlayerWin_ThenPlayerIsNotNil() {

        XCTAssertNotNil(match.isOver)
    }
    func testGivenCurrentGameScoreIsNull_WhenPointIsAdded_ScoreIsOnlyIncremented() {

        match.pointEnded(wonBy: .one)

        XCTAssertEqual(match.sets.count, 1)
        XCTAssertEqual(match.sets.last!.games.count, 1)
        XCTAssertEqual(match.currentGame.scores[.one]!, 15)
    }

    func testGivenCurrentGameScoreIsForty_WhenPointIsAdded_GameIsEndedAndNewGameIsCreated() {

        match.currentGame.scores[.one] = 40
        match.pointEnded(wonBy: .one)

        XCTAssertTrue(match.sets.last!.games.first!.isOver)
        XCTAssertEqual(match.sets.last?.games.count, 2)
    }

    func testGivenCurrentGameScoreIsFortyAndSetScoreIs5_WhenPointIsAdded_SetIsEndedAndNewSetIsCreated() {

        createManyGames(5, wonByPlayer: .one, inSet: match.sets.last!)

        match.sets.last?.games.append(Game())

        match.currentGame.scores[.one] = 40
        match.pointEnded(wonBy: .one)

        XCTAssertTrue(match.sets.first!.games.last!.isOver)
        XCTAssertEqual(match.sets.count, 2)
    }

    func testGivenCurrentScoreIs40AndSetScoreIs5To6_WhenPointIsAdded_ThenTieBreakGameIsCreated() {

        createManyGames(5, wonByPlayer: .one, inSet: match.sets.last!)
        createManyGames(6, wonByPlayer: .two, inSet: match.sets.last!)

        match.sets.last?.games.append(Game())
        match.currentGame.scores[.one] = 40
        match.pointEnded(wonBy: .one)

        XCTAssert(match.currentGame is TieBreakGame)
    }
    func testGivenScoreIs40To30_WhenIncrementingP2Score_ThenGameIsNotOverAndAdvantageGameIsCreated() {
        match.currentGame.scores[.one] = 40
        match.currentGame.scores[.two] = 30

        match.pointEnded(wonBy: .two)
        XCTAssertFalse(match.currentGame.isOver)
        XCTAssert(match.currentGame is AdvantageGame)
    }
}
