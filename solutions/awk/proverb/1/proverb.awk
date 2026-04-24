# With reverence and dedication to Shree DR.MDD
BEGIN { RS = "[[:space:]]+" }

!root { root = anchor = $1; next }

{
  printf "For want of a %s the %s was lost.\n", anchor, $1
  anchor = $1
}

END {
  if (root)
    printf "And all for the want of a %s.\n", root
}
