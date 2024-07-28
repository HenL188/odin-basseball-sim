package main

import "core:fmt"

main :: proc() {
	scores := make(map[string]int)
	defer delete(scores)
	scores["Team 1"] = 0
	scores["Team 2"] = 0
	scores["Team 2"] += 2
	fmt.println(scores["Team 2"])
	if scores["Team 2"] > scores["Team 1"] {
		fmt.println("team 2 wins")
	}

	hitter: Hitter
	hitter.bases_empty = true
	team: Team

	for team_one_outs != 0 {
		team = .team_one
	}

	for team_two_outs != 0 {
		team = .team_two
	}

	/*if hit.hit == true {
		triple()
		homerun()
		douple()
		single()
	}*/
}
