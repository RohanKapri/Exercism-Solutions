function verse(num) {
  printf("This is ")
  for (i=num; i>1; i--)
    printf("the %s that %s ", obj[i], verb[i])
  printf("the %s\n", obj[1])
}

BEGIN {
  obj[12]="horse and the hound and the horn"
  verb[12]="belonged to"
  obj[11]="farmer sowing his corn"
  verb[11]="kept"
  obj[10]="rooster that crowed in the morn"
  verb[10]="woke"
  obj[9]="priest all shaven and shorn"
  verb[9]="married"
  obj[8]="man all tattered and torn"
  verb[8]="kissed"
  obj[7]="maiden all forlorn"
  verb[7]="milked"
  obj[6]="cow with the crumpled horn"
  verb[6]="tossed"
  obj[5]="dog"
  verb[5]="worried"
  obj[4]="cat"
  verb[4]="killed"
  obj[3]="rat"
  verb[3]="ate"
  obj[2]="malt"
  verb[2]="lay in"
  obj[1]="house that Jack built."

  if ((start>=1) && (start<=12)) {
    if ((end>=start) && (end<=12)) {
      for (v=start; v<=end; v++)
        verse(v)
      exit 0
    }
  }

  print "invalid"
  exit 1
}