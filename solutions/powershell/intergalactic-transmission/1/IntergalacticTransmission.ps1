Function Invoke-Transmitter() {
    <#
    .SYNOPSIS
    Implement the transmitter to calculates the transmission sequence.

    .DESCRIPTION
    Implement a function that accept a sequence and encode it with parity bits to help detecting transmission errors.

    .PARAMETER Sequence
    An array of hexadecimal values.

    .EXAMPLE
    Invoke-Transmitter -Sequence @(0x05)
    Returns: @(0x05, 0x81)
    #>
    [CmdletBinding()]
    Param(
        [byte[]]$Sequence
    )
    [byte[]]$result = @()
    [short]$acc = 0
    $accLen = 0
    foreach ($byte in $Sequence) {
        $acc = ($acc -shl 8) -bor $byte
        for ($accLen += 8; $accLen -gt 7; $accLen -= 7) {
            $bits = ($acc -shr ($accLen - 7)) -band 0x7f
            $parity = [Numerics.BitOperations]::PopCount($bits) -band 1
            $result += ($bits -shl 1) -bor $parity
        }
    }

    if ($accLen -gt 0) {
        $bits = ($acc -shl (7 - $accLen)) -band 0x7f
        $parity = [Numerics.BitOperations]::PopCount($bits) -band 1
        $result += ($bits -shl 1) -bor $parity
    }

    $result
}

Function Invoke-Receiver() {
    <#
    .SYNOPSIS
    Implement the receiver to decode the transmission sequence.

    .DESCRIPTION
    Implement a function to receive a sequence and decode it to the original message.

    .PARAMETER Sequence
    An array of hexadecimal values.

    .EXAMPLE
    Invoke-Receiver -Sequence @(0x05, 0x81)
    Returns: @(0x05)
    #>
    [CmdletBinding()]
    Param(
        [byte[]]$Sequence
    )
    [byte[]]$result = @()
    [short]$acc = 0
    $accLen = 0
    foreach ($byte in $Sequence) {
        if ([Numerics.BitOperations]::PopCount($byte) -band 1) { Throw "wrong parity" }
        $acc = ($acc -shl 7) -bor ($byte -shr 1)
        for ($accLen += 7; $accLen -ge 8; $accLen -= 8) { $result += ($acc -shr ($accLen - 8)) -band 0xff }
    }

    $result
}