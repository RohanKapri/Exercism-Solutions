import scala.annotation.tailrec

object FlowerField {
  private def withCoords(board: List[String]): List[(Char, (Int, Int))] = {
    board.zipWithIndex.flatMap { (arow, rowN) =>
      arow.zipWithIndex.map { (char, colN) =>
        (char, (rowN, colN))
      }.toList
    }
  }

  @tailrec
  private def updateMapWithList(map: Map[(Int, Int), Int], alist: List[(Int, Int)]): Map[(Int, Int), Int] =
    alist match {
      case head :: tail =>
        val currentValue = map.getOrElse(head, 0)
        val newMap = map.updated(head, currentValue + 1)
        updateMapWithList(newMap, tail)
      case _ => map
    }

  private def getAffectedCoordsList(rowN: Int, colN: Int): List[(Int, Int)] =
    List(
      (rowN, colN - 1), (rowN, colN), (rowN, colN + 1),
      (rowN - 1, colN - 1), (rowN - 1, colN), (rowN - 1, colN + 1),
      (rowN + 1, colN - 1), (rowN + 1, colN), (rowN + 1, colN + 1),
    )

  @tailrec
  private def collectCoordsMap(mapCoords: Map[(Int, Int), Int], left: List[(Char, (Int, Int))]): Map[(Int, Int), Int] =
    left match
      case head :: tail =>
        val (char, (rowN, colN)) = head
        val newMap = if char == '*' then updateMapWithList(mapCoords, getAffectedCoordsList(rowN, colN)) else mapCoords
        collectCoordsMap(newMap, tail)
      case _ => mapCoords

  private def annotateBoard(board: List[(Char, (Int, Int))]): List[(String, (Int, Int))] = {
    val coordsMap = collectCoordsMap(Map(), board)

    @tailrec
    def loop(acc: List[(String, (Int, Int))], left: List[(Char, (Int, Int))]): List[(String, (Int, Int))] =
      left match
        case head :: tail =>
          val (char, (rowN, colN)) = head
          val newAccElement: String = if char == '*' then "*" else coordsMap.get((rowN, colN)).map(_.toString).getOrElse(" ")
          loop(acc :+ (newAccElement, (rowN, colN)), tail)
        case _ => acc

    loop(List(), board)
  }

  private def collectToBoard(boardWithIdx: List[(String, (Int, Int))]): List[String] =
    boardWithIdx.groupBy { case (_, (rowN, _)) => rowN }
      .view.mapValues { alist =>
        alist.sortBy { case (_, (_, idx)) => idx }.map { case (char, _) => char }.mkString
      }.toList.sortBy { case (rowN, _) => rowN }.map { case (_, str) => str }

  def annotate(board: List[String]): List[String] = {
    val res = collectToBoard(annotateBoard(withCoords(board)))
    if board.length == 1 && res.isEmpty then List("") else res
  }
}