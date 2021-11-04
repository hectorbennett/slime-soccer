# https://godotengine.org/qa/70842/how-to-make-global-constants-and-variables
extends Node

var gameInProgress := false
var isPaused := false
var left_score := 0
var right_score := 0

const teams = [
	{'name': 'Argentina', 'body': '0AFDFF', 'decoration': 'FFFFFF'},
	{'name': 'Spain', 'body': 'CF0000', 'decoration': '05008B'},
	{'name': 'Italy', 'body': '817CFF', 'decoration': 'FFFFFF'},
	{'name': 'Japan', 'body': '06008B', 'decoration': 'FFFFFF'},
	{'name': 'Senegal', 'body': 'FFFFFF', 'decoration': 'FF7900'},
	{'name': 'South Corea', 'body': 'FF0000', 'decoration': 'FFFFFF'},
	{'name': 'Australia', 'body': '00FF00', 'decoration': 'FFFFFF'},
	{'name': 'P.R. of China', 'body': 'FFFFFF', 'decoration': 'FF0000'},
	{'name': 'Cameroon', 'body': '008700', 'decoration': 'FF0000'},
	{'name': 'Costa Rica', 'body': '8B0000', 'decoration': '05008B'},
	{'name': 'Tunisia', 'body': 'FFFFFF', 'decoration': 'FF0000'},
	{'name': 'Uruguay', 'body': '00B9B6', 'decoration': '000200'},
	{'name': 'Germany', 'body': 'FFFFFF', 'decoration': '010202'},
	{'name': 'Slovenia', 'body': 'FFFFFF', 'decoration': '008400'},
	{'name': 'Sveden', 'body': 'FEF100', 'decoration': '1100FF'},
	{'name': 'England', 'body': 'E6E7E7', 'decoration': 'FF0000'},
	{'name': 'Crotia', 'body': '9A0000', 'decoration': 'FFFFFF'},
	{'name': 'Denmark', 'body': '851E0E', 'decoration': 'FFFFFF'},
	{'name': 'Eucador', 'body': 'FDFF00', 'decoration': '070080'},
	{'name': 'Mexico', 'body': '00FF00', 'decoration': '00FF00'},
	{'name': 'France', 'body': 'FFFFFF', 'decoration': '1200FF'},
	{'name': 'Paraguay', 'body': 'FF0000', 'decoration': 'FFFFFF'},
	{'name': 'Poland', 'body': 'FFFFFF', 'decoration': 'FF0000'},
	{'name': 'Russia', 'body': 'FFFFFF', 'decoration': '1200FF'},
	{'name': 'Portugal', 'body': '7E2405', 'decoration': '008700'},
	{'name': 'Ireland', 'body': '00FF00', 'decoration': 'FFFFFF'},
	{'name': 'Senegal', 'body': 'FFFFFF', 'decoration': 'FF7800'},
	{'name': 'Saudi Arabia', 'body': 'FFFFFF', 'decoration': '28FF70'},
	{'name': 'Seth Efrica', 'body': 'FFFFFF', 'decoration': '27AC4A'},
]
