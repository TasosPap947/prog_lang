fun addto [] _ = []
	| addto (h::t) n = (h+n) :: addto t n
