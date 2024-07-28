package main

import "core:fmt"

main :: proc() {
	scores := make(map[string]int)
	defer delete(scores)
	scores["Team 1"] = 0
	scores["Team 2"] = 0

	hitter: Hitter
	hitter.bases_empty = true
	team_outs: Team
	team: string

	for team_one_outs != 0 {
		team_outs = .team_one
		//player(hitter, 3.2, 0, 0, 0)
	}

	for team_two_outs != 0 {
		team_outs = .team_two
	}

	if scores["Team 1"] > scores["Team 2"] {
		fmt.println("Team 1 wins")
		fmt.printfln("Team 1: %i", scores["Team 1"])
		fmt.printfln("Team 2: %i", scores["Team 2"])
	} else if scores["Team 2"] > scores["Team 1"] {
		fmt.println("Team 2 wins")
		fmt.printfln("Team 1: %i", scores["Team 1"])
		fmt.printfln("Team 2: %i", scores["Team 2"])
	} else {
		fmt.println("Tied after nine")
		fmt.printfln("Team 1: %i", scores["Team 1"])
		fmt.printfln("Team 2: %i", scores["Team 2"])
	}
}
