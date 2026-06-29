Function Get-LineUp() {
    <#
    .SYNOPSIS
    Produce a greeting for customer in a line.
    
    .DESCRIPTION
    Given a name and a number, your task is to produce a sentence using that name and that number as an ordinal numeral.

    .PARAMETER Name
    String represents name of the customer.

    .PARAMETER Number
    Integer represents the order of the customer in line. (1 to 999)

    .EXAMPLE
    Get-LineUp -Name "Exercism" -Number 1
    Returns: "Exercism, you are the 1st customer we serve today. Thank you!"
    #>
    [CmdletBinding()]
    Param(
        [string]$Name,
        [int]$Number
    )
    switch([string]$number){
        {$_[-1] -eq "1"} { $post = "st" }
        {$_[-1] -eq "2"} { $post = "nd" }
        {$_[-1] -eq "3"} { $post = "rd" }
        {$_ -match ".*1[123]$"} { $post = "th" }
        default { $post = "th" }
    }
    return ("$name, you are the " + [string]$number + "$post customer we serve today. Thank you!")
}