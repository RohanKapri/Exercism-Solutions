module eliuds_eggs

  implicit none

contains

  integer function eggCount(number)
    integer :: number, remaining

    eggCount = 0
    remaining = number
    do while (remaining > 0)
      eggCount = eggCount + iand(remaining, 1)
      remaining = shiftr(remaining, 1)
    end do
  end function

end module