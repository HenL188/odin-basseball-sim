package main
import "core:fmt"
import "core:math/rand"


walk :: proc(hitter: ^Hitter) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[89] {
		hitter.walk = true
	}
}

hit :: proc(hitter: ^Hitter, BA: int) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[BA] {
		hitter.hit = true
	}
}

single :: proc(hitter: ^Hitter, scores: ^map[string]int, team: string) {
	ran := rand.choice(batting_avg[:])
	if hitter.double == false && hitter.triple == false && hitter.homerun == false {
		hitter.single = true
		hitter.hit = false
		bases_single(hitter, scores, team)
	}

}

double :: proc(hitter: ^Hitter, dp: int, scores: ^map[string]int, team: string) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[dp] &&
	   hitter.triple == false &&
	   hitter.homerun == false &&
	   hitter.single == false {
		hitter.double = true
		hitter.hit = false
		bases_double(hitter, scores, team)
	}
}

triple :: proc(hitter: ^Hitter, tp: int, scores: ^map[string]int, team: string) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[tp] &&
	   hitter.triple == false &&
	   hitter.single == false &&
	   hitter.double == false {
		hitter.triple = true
		hitter.hit = false
		bases_triple(hitter, scores, team)
	}
}

homerun :: proc(hitter: ^Hitter, hp: int, scores: ^map[string]int, team: string) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[hp] &&
	   hitter.triple == false &&
	   hitter.single == false &&
	   hitter.double == false {
		hitter.homerun = true
		hitter.hit = false
		bases_homerun(hitter, scores, team)
	}
}

strike :: proc(hitter: ^Hitter, so: int, team: Team) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[so] &&
	   hitter.fo == false &&
	   hitter.po == false &&
	   hitter.go == false &&
	   hitter.ld == false {
		hitter.so = true
		switch team {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

pop_out :: proc(hitter: ^Hitter, po: int, team: Team) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[po] &&
	   hitter.fo == false &&
	   hitter.so == false &&
	   hitter.go == false &&
	   hitter.ld == false {
		hitter.po = true
		switch team {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

fly_out :: proc(hitter: ^Hitter, fo: int, team: Team) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[fo] &&
	   hitter.po == false &&
	   hitter.so == false &&
	   hitter.go == false &&
	   hitter.ld == false {
		hitter.fo = true
		switch team {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

line_drive :: proc(hitter: ^Hitter, ld: int, team: Team) {
	ran := rand.choice(batting_avg[:])
	if ran <= batting_avg[ld] &&
	   hitter.fo == false &&
	   hitter.so == false &&
	   hitter.go == false &&
	   hitter.po == false {
		hitter.ld = true
		switch team {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
	}
}

ground_out :: proc(hitter: ^Hitter, team: Team) {
	ran := rand.choice(batting_avg[:])
	if hitter.fo == false && hitter.so == false && hitter.ld == false && hitter.po == false {
		hitter.go = true
		switch team {
		case .team_one:
			team_one_outs -= 1
		case .team_two:
			team_two_outs -= 1
		}
		switch team {
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
	case hitter.single && hitter.first_base:
		hitter.second_base = true
		hitter.first_base = true
		hitter.bases_empty = false
	case hitter.single && hitter.first_base && hitter.second_base:
		hitter.third_base = true
		hitter.second_base = true
		hitter.first_base = true
		hitter.bases_empty = false
	case hitter.single && hitter.first_base && hitter.second_base && hitter.third_base:
		scores[team] += 1
		hitter.third_base = false
		hitter.second_base = true
		hitter.first_base = true
		hitter.bases_empty = false
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
}
