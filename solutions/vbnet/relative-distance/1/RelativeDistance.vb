Imports System

Public Module RelativeDistance
  
    Public Function DegreesOfSeparation(ByVal familyTree As Dictionary(Of String, String()), ByVal personA As String, ByVal personB As String) As Integer

        Dim visited As New HashSet(Of String)
        Dim queue As New Queue(Of (Person As String, Distance As Integer))
        Dim graph As Dictionary(Of String, List(Of String)) = BuildGraph(familyTree)

        queue.Enqueue((personA, 0))

        While queue.Count > 0

            Dim current = queue.Dequeue()

            If current.Person = personB Then
                Return current.Distance
            End If

            If visited.Add(current.Person) Then
                If graph.ContainsKey(current.Person) Then
                    For Each neighbor In graph(current.Person)
                        If Not visited.Contains(neighbor) Then
                            queue.Enqueue((neighbor, current.Distance + 1))
                        End If
                    Next
                End If
            End If

        End While

        Return -1

    End Function

    Function BuildGraph(tree As Dictionary(Of String, String())) As Dictionary(Of String, List(Of String))

        Dim graph As New Dictionary(Of String, List(Of String))

        Dim addEdge = Sub(a As String, b As String)
                          If Not graph.ContainsKey(a) Then graph(a) = New List(Of String)
                          If Not graph.ContainsKey(b) Then graph(b) = New List(Of String)

                          If Not graph(a).Contains(b) Then graph(a).Add(b)
                          If Not graph(b).Contains(a) Then graph(b).Add(a)
                      End Sub

        For Each kvp In tree

            Dim parent = kvp.Key
            Dim children = kvp.Value

            For Each child In children
                addEdge(parent, child)
            Next

            For i = 0 To children.Length - 1
                For j = i + 1 To children.Length - 1
                    addEdge(children(i), children(j))
                Next
            Next

        Next

        Return graph

    End Function

End Module