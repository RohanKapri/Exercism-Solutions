class Roster
  new: (list) =>
    seen = {}
    grades = {}
    roster = {}
    added = {}
    put = table.insert
    sort = table.sort

    for st in *list
      {name, grade} = st
      to_add = false
      unless seen[name]
        seen[name] = true
        unless roster[grade]
          roster[grade] = {}
          put grades, grade
        put roster[grade], name
        to_add = true
      put added, to_add

    sort grades
    for _, names in pairs roster
      sort names

    @grades = grades
    @roster = roster
    @added = added

  get_roster: =>
    [ name for g in *@grades for name in *@roster[g] ]
  get_grade: (g) =>
    return {} unless @roster[g]
    [ name for name in *@roster[g] ]
    
{
  roster: (list) -> 
    (Roster list)\get_roster!
  add: (list) -> 
    (Roster list).added
  grade: (list, grade) -> 
    (Roster list)\get_grade grade
}