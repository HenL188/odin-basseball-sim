package main

import "core:fmt"

main :: proc() {
	scores := make(map[string]int)
	defer delete(scores)
	scores["Team 1"] = 0
	scores["Team 2"] = 0

	hitter: Hitter = {
		bases_empty = true,
	}
	team_outs: Team

	for team_one_outs >= 0 {
		team_outs = .team_one
		if team_one_outs <= 0 {
			break
		}
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		fmt.printfln("Team one: %i", team_one_outs)
		fmt.println(scores["Team 1"])
	}

	for team_two_outs >= 0 {
		team_outs = .team_two
		if team_two_outs <= 0 {
			break
		}
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		player(&hitter, 3.2, 1.3, .22, 0.1, .25, 2.2, .4, 2.9, 2.5, &scores, "Team 1", team_outs)
		fmt.printfln("Team Two: %i", team_two_outs)
		fmt.println(scores["Team 2"])
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
