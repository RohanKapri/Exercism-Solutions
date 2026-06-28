BEGIN {
	# define the field separator
	FS = ","
}

{
	# generate and print the output for each record
	first_reading = $3 * 10 + $4
	second_reading = $5 * 10 + $6
	average = (first_reading + second_reading) / 2
	printf "#%s, %s = %d\n", $1, $2, average
}
