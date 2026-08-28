Red [
	description: {"Flower Field" exercise solution for exercism platform}
	author: "Rohan Kapri"
]

annotate: function [
	garden [block!]
] [
	if empty? garden [return copy []]
	
	row-count: length? garden
	col-count: length? garden/1
	
	; Create a deep copy of the garden to store our results
	result: copy/deep garden
	
	; Loop through each cell in the grid
	repeat r row-count [
		row-str: pick garden r
		repeat c col-count [
			
			; Process only if the current spot is empty
			if (pick row-str c) = #" " [
				flower-count: 0
				
				; Check all 8 neighboring directions around (r, c)
				foreach dr [-1 0 1] [
					foreach dc [-1 0 1] [
						
						; Skip comparing the center cell to itself
						if not (all [dr = 0 dc = 0]) [
							nr: r + dr
							nc: c + dc
							
							; Safe boundary checks using Red's short-circuit 'all' block
							if all [
								nr >= 1 
								nr <= row-count 
								nc >= 1 
								nc <= col-count
							] [
								neighbor-row: pick garden nr
								neighbor-cell: pick neighbor-row nc
								if neighbor-cell = #"*" [
									flower-count: flower-count + 1
								]
							]
						]
					]
				]
				
				; If flowers were found, overwrite the blank space with the count character
				if flower-count > 0 [
					target-row: pick result r
					poke target-row c (to char! (48 + flower-count))
				]
			]
		]
	]
	
	return result
]