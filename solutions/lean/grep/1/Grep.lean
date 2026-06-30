namespace Grep

structure Flags where
  lineNumbers : Bool := false
  fileNames : Bool := false
  ignoreCase : Bool := false
  invert : Bool := false
  wholeLine : Bool := false

private def parseArgs (args : List String) : Flags × List String :=
  let (flags, revFiles) :=
    args.foldl
    (fun (acc : Flags × List String) arg =>
      let (flags, filesRev) := acc
      match arg with
      | "-n" => ({ flags with lineNumbers := true }, filesRev)
      | "-l" => ({ flags with fileNames := true }, filesRev)
      | "-i" => ({ flags with ignoreCase := true }, filesRev)
      | "-v" => ({ flags with invert := true }, filesRev)
      | "-x" => ({ flags with wholeLine := true }, filesRev)
      | file => (flags, file :: filesRev))
    ({}, [])
  (flags, revFiles.reverse)

private def matchesLine (queryNormalized line : String) (flags : Flags) : Bool :=
  let l := if flags.ignoreCase then line.toLower else line
  let matched :=
    if flags.wholeLine then
      l = queryNormalized
    else
      l.contains queryNormalized
  if flags.invert then !matched else matched

private def fileLines (content : String) : Array String :=
  let lines := (content.splitOn "\n").toArray
  if content.endsWith "\n" && lines.size > 0 then
    lines.extract 0 (lines.size - 1)
  else
    lines

def grep (args : List String) : IO Unit :=
  match args with
  | [] =>
      IO.print "Called without arguments\n"
  | query :: rest =>
      let (flags, files) := parseArgs rest
      if files.isEmpty then
        IO.print "Called without a file name\n"
      else do
        let fileList := files
        let includeFileName := fileList.length > 1
        let queryNormalized := if flags.ignoreCase then query.toLower else query

        for file in fileList do
          let content <-
            try
              IO.FS.readFile file
            catch _ =>
              IO.print "File not found\n"
              return

          let lines := fileLines content
          let mut foundInFile := false
          let filePrefix := if includeFileName then file ++ ":" else ""
          let mut i := 0

          while i < lines.size && !(flags.fileNames && foundInFile) do
            let line := lines[i]!
            if matchesLine queryNormalized line flags then
              foundInFile := true
              if flags.fileNames then
                IO.print (file ++ "\n")
              else
                let linePrefix := if flags.lineNumbers then toString (i + 1) ++ ":" else ""
                IO.print (filePrefix ++ linePrefix ++ line ++ "\n")
            i := i + 1

end Grep