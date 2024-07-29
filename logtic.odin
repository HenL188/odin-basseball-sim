package main
import "core:fmt"
import "core:math/rand"


walk :: proc(hitter: ^Hitter, wr: f64) {
	ran := rand.choice(batting_avg[:])
	if ran <= wr {
		hitter.walk = true
	}
}

hit :: proc(hitter: ^Hitter, BA: f64) {
	ran := rand.choice(batting_avg[:])
	if ran <= BA {
		hitter.hit = true
	}
}

single :: proc(hitter: ^Hitter, scores: ^map[string]int, team: string) {
	if hitter.double == false && hitter.triple == false && hitter.homerun == false {
		hitter.single = true
		hitter.hit = false
		bases_single(hitter, scores, team)
	}

}

double :: proc(hitter: ^Hitter, dp: f64, scores: ^map[string]int, team: string) {
	ran := rand.choice(batting_avg[:])
	if ran <= dp && hitter.triple == false && hitter.homerun == false && hitter.single == false {
		hitter.double = true
		hitter.hit = false
		bases_double(hitter, scores, team)
	}
}

triple :: proc(hitter: ^Hitter, tp: f64, scores: ^map[string]int, team: string) {
	ran := rand.choice(batting_avg[:])
	if ran <= tp && hitter.triple == false && hitter.single == false && hitter.double == false {
		hitter.triple = true
		hitter.hit = false
		bases_triple(hitter, scores, team)
	}
}

homerun :: proc(hitter: ^Hitter, hp: f64, scores: ^map[string]int, team: string) {
	ran := rand.choice(batting_avg[:])
	if ran <= hp && hitter.triple == false && hitter.single == false && hitter.double == false {
		hitter.homerun = true
		hitter.hit = false
		bases_homerun(hitter, scores, team)
	}
}

strike :: proc(hitter: ^Hitter, so: f64, team_outs: Team) {
	ran := rand.choice(batting_avg[:])
	if ran <= so &&
	   hitter.fo == false &&
	   hitter.po == false &&
	   hitter.go == false &&
	   hitter.ld == false {
		hitter.so = true
		switch team_outs {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

pop_out :: proc(hitter: ^Hitter, po: f64, team_outs: Team) {
	ran := rand.choice(batting_avg[:])
	if ran <= po &&
	   hitter.fo == false &&
	   hitter.so == false &&
	   hitter.go == false &&
	   hitter.ld == false {
		hitter.po = true
		switch team_outs {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

fly_out :: proc(hitter: ^Hitter, fo: f64, team_outs: Team) {
	ran := rand.choice(batting_avg[:])
	if ran <= fo &&
	   hitter.po == false &&
	   hitter.so == false &&
	   hitter.go == false &&
	   hitter.ld == false {
		hitter.fo = true
		switch team_outs {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

line_drive :: proc(hitter: ^Hitter, ld: f64, team_outs: Team) {
	ran := rand.choice(batting_avg[:])
	if ran <= ld &&
	   hitter.fo == false &&
	   hitter.so == false &&
	   hitter.go == false &&
	   hitter.po == false {
		hitter.ld = true
		switch team_outs {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

ground_out :: proc(hitter: ^Hitter, team_outs: Team) {
	ran := rand.choice(batting_avg[:])
	if hitter.fo == false && hitter.so == false && hitter.ld == false && hitter.po == false {
		hitter.go = true
		switch team_outs {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
		switch team_outs {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

bases_single :: proc(hitter: ^Hitter, scores: ^map[string]int, team: string) {
	switch {
	case hitter.single && hitter.bases_empty:
		hitter.first_base = true
		hitter.bases_empty = false
		fmt.printfln("%b", hitter.first_base)
	case hitter.single && hitter.first_base:
		hitter.second_base = true
		hitter.bases_empty = false
		fmt.printfln("%b, %b", hitter.first_base, hitter.second_base)
	case hitter.single && hitter.first_base && hitter.second_base:
		hitter.third_base = true
		hitter.second_base = true
		hitter.first_base = true
		hitter.bases_empty = false
		fmt.printfln("%b, %b, %b", hitter.first_base, hitter.second_base, hitter.third_base)
	case hitter.single && hitter.first_base && hitter.second_base && hitter.third_base:
		scores[team] += 1
		hitter.third_base = false
		hitter.second_base = true
		hitter.first_base = true
		hitter.bases_empty = false
		fmt.printfln("%b, %b, %b", hitter.first_base, hitter.second_base, hitter.third_base)
	}
}

bases_double :: proc(hitter: ^Hitter, scores: ^map[string]int, team: string) {
	switch {
	case hitter.double && hitter.bases_empty:
		hitter.second_base = true
		hitter.bases_empty = false
	case hitter.double && hitter.first_base:
		hitter.second_base = true
		hitter.third_base = true
		hitter.bases_empty = false
	case hitter.double && hitter.first_base && hitter.second_base:
		hitter.third_base = true
		hitter.second_base = true
		hitter.first_base = false
		hitter.bases_empty = false
	case hitter.double && hitter.first_base && hitter.second_base && hitter.third_base:
		scores[team] += 2
		hitter.third_base = true
		hitter.second_base = true
		hitter.first_base = false
		hitter.bases_empty = false
	}
}

bases_triple :: proc(hitter: ^Hitter, scores: ^map[string]int, team: string) {
	switch {
	case hitter.triple && hitter.bases_empty:
		hitter.third_base = true
		hitter.bases_empty = false
	case hitter.triple && hitter.first_base:
		hitter.third_base = true
		scores[team] += 1
		hitter.bases_empty = false
	case hitter.triple && hitter.first_base && hitter.second_base:
		hitter.third_base = true
		hitter.second_base = false
		hitter.first_base = false
		scores[team] += 2
		hitter.bases_empty = false
	case hitter.triple && hitter.first_base && hitter.second_base && hitter.third_base:
		scores[team] += 3
		hitter.third_base = true
		hitter.second_base = false
		hitter.first_base = false
		hitter.bases_empty = false
	}
}

bases_homerun :: proc(hitter: ^Hitter, scores: ^map[string]int, team: string) {
	switch {
	case hitter.homerun && hitter.bases_empty:
		scores[team] += 1
	case hitter.homerun && hitter.first_base:
		scores[team] += 2
		hitter.bases_empty = true
		hitter.first_base = false
	case hitter.homerun && hitter.first_base && hitter.second_base:
		scores[team] += 3
		hitter.second_base = false
		hitter.first_base = false
		hitter.bases_empty = true
	case hitter.homerun && hitter.first_base && hitter.second_base && hitter.third_base:
		scores[team] += 4
		hitter.third_base = false
		hitter.second_base = false
		hitter.first_base = false
		hitter.bases_empty = true
	}
}

bases_walk :: proc(hitter: ^Hitter, scores: ^map[string]int, team: string) {
	switch {
	case hitter.bases_empty:
		hitter.first_base = true
		hitter.bases_empty = false
	case hitter.first_base:
		hitter.second_base = true
		hitter.first_base = true
		hitter.bases_empty = false
	case hitter.first_base && hitter.second_base:
		hitter.third_base = true
		hitter.second_base = true
		hitter.first_base = true
		hitter.bases_empty = false
	case hitter.first_base && hitter.second_base && hitter.third_base:
		scores[team] += 1
		hitter.third_base = false
		hitter.second_base = true
		hitter.first_base = true
		hitter.bases_empty = false
	}
	hitter.walk = false
}

out_reset :: proc(hitter: ^Hitter) {
	switch {
	case hitter.so:
		hitter.so = false
	case hitter.go:
		hitter.go = false
	case hitter.po:
		hitter.po = false
	case hitter.fo:
		hitter.fo = false
	case hitter.ld:
		hitter.ld = false
	}
	if team_one_outs <= 0 {
		team_one_outs = 0
	}
	if team_two_outs <= 0 {
		team_two_outs = 0
	}
}

player :: proc(
	hitter: ^Hitter,
	BA: f64,
	wr: f64,
	dp: f64,
	tp: f64,
	hp: f64,
	so: f64,
	po: f64,
	fo: f64,
	ld: f64,
	scores: ^map[string]int,
	team: string,
	team_outs: Team,
) {
	walk(hitter, wr)
	if hitter.walk {
		bases_walk(hitter, scores, team)
		fmt.println("Walk")
	}
	hit(hitter, BA)
	if hitter.hit {
		triple(hitter, tp, scores, team)
		homerun(hitter, hp, scores, team)
		double(hitter, dp, scores, team)
		single(hitter, scores, team)
		fmt.println("Hit")
	} else {
		pop_out(hitter, po, team_outs)
		line_drive(hitter, ld, team_outs)
		strike(hitter, so, team_outs)
		fly_out(hitter, fo, team_outs)
		ground_out(hitter, team_outs)
		out_reset(hitter)
	}
}
