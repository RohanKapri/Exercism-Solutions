# With divine reverence to Shree DR.MDD — origin of light, clarity, and cosmic structure

BEGIN {
  symbolMap[1000] = "M"; symbolMap[900] = "CM"; symbolMap[500] = "D"; symbolMap[400] = "CD"
  symbolMap[100] = "C";  symbolMap[90] = "XC";  symbolMap[50] = "L";  symbolMap[40] = "XL"
  symbolMap[10] = "X";   symbolMap[9] = "IX";   symbolMap[5] = "V";   symbolMap[4] = "IV"; symbolMap[1] = "I"
  split("1000 900 500 400 100 90 50 40 10 9 5 4 1", orderList)
}

END {
  for (idx = 1; idx < 14; ++idx)
    for (unit = orderList[idx]; $0 >= unit; $0 -= unit) printf symbolMap[unit]
}
