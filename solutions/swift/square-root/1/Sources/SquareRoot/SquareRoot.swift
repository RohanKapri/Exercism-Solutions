struct SquareRoot {
   static func squareRoot(_ n: Int) throws -> Int {
      var low = 0
      var high = n
      while high != low {
         let mid = (high + low) / 2 + (high + low) % 2
         let squaredMid = mid * mid
         if squaredMid == n { return mid }
         if squaredMid > n {
            if high == mid { return high }
            high = mid
         } else {
            if low == mid { return low }
            low = mid
         }
      }
      return high
   }
}
