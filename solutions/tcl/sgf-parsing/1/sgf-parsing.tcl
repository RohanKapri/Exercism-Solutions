proc parse {input} {
	if {$input == {}} {typeError "None" {LPAREN}}
	tailcall parseToken [lex $input]
}

proc parseToken {tokens} {
	set properties [dict create]
	set key ""
	set children [list]
	set in_child yes
	set child_stack [list]
	set expected_types {LPAREN}
	foreach token $tokens {
		lassign $token type content
		if {$type ni $expected_types} {
			typeError $type $expected_types
		}
		switch $type {
			LPAREN {
				set in_child [expr {!$in_child}]
				set expected_types {SEMI}
			}
			RPAREN {
				if {$in_child} {
					set in_child no
					lappend child_stack $token
					lappend children [parseToken [linsert $child_stack 0 [list LPAREN \(]]]
					set child_stack [list]
				}
				set expected_types {LPAREN RPAREN}
			}
			LBRAKET {
				if {$in_child} {lappend child_stack $token}
				set expected_types {SGF}
			}
			RBRAKET {
				if {$in_child} {lappend child_stack $token}
				set expected_types {LPAREN RPAREN LBRAKET SEMI KEY}
			}
			SEMI {
				if {$expected_types != {SEMI}} {set in_child yes}
				if {$in_child} {lappend child_stack $token}
				set expected_types {KEY RPAREN}
			}
			KEY {
				if {$in_child} {
					lappend child_stack $token
				} else {
					if {![string is upper $content]} {
						error "property must be in uppercase"
					} else {set key $content}
				}
				set expected_types {LBRAKET}
			}
			SGF {
				if {$in_child} {
					lappend child_stack $token
				} else {
					dict lappend properties $key $content
				}
				set expected_types {RBRAKET}
			}
			default {error "Unknow type $type token: $content"}
		}
	}
	return [dict create properties $properties children $children]
}

proc lex {input} {
	set tokens [list]
	set in_sgf_text no
	set prev_esc_ch no
	set str ""
	foreach ch [split $input {}] {
		if {$in_sgf_text} {
			if {$prev_esc_ch} {
				if {$ch == "n"} {set ch "\n"}
				if {$ch == "t"} {set ch "\t"}
				set prev_esc_ch no
				append str $ch; continue
			}
			if {$ch == "\\"} {set prev_esc_ch yes; continue}
			if {$ch != "\]"} {append str $ch; continue}
		}
		switch $ch {
			\( {
				clearStr str tokens $in_sgf_text
				set in_sgf_text no
				lappend tokens [list LPAREN $ch]
			}
			\) {
				clearStr str tokens $in_sgf_text
				set in_sgf_text no
				lappend tokens [list RPAREN $ch]
			}
			\[ {
				clearStr str tokens $in_sgf_text
				set in_sgf_text yes
				lappend tokens [list LBRAKET $ch]
			}
			\] {
				clearStr str tokens $in_sgf_text
				set in_sgf_text no
				lappend tokens [list RBRAKET $ch]
			}
			\; {
				clearStr str tokens $in_sgf_text
				set in_sgf_text no
				lappend tokens [list SEMI $ch]
			}
			default {
				append str $ch
			}
		}
	}
	return $tokens
}

proc clearStr {strName tokensName in_sgf_text} {
	upvar $strName str $tokensName tokens
	if {$str != ""} {
		if {$in_sgf_text} {
			regsub -all "\t" $str " " str
			regsub -all {\\([tn ])} $str {\1} str
			regsub -all {\\\n} $str {} str
			lappend tokens [list "SGF" $str] 
		} else {
			lappend tokens [list "KEY" $str]
		}
		set str ""
	}
}

proc typeError {type expected_types} {
	if {$expected_types == {SEMI}}    {error "tree with no nodes"}
	if {"LPAREN" in $expected_types}  {error "tree missing"}
	if {$expected_types == {LBRAKET}} {error "properties without delimiter"}
	error "$type, $expected_types"
}