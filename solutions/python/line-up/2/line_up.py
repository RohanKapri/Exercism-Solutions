"""Generate a customer queue message with the correct ordinal suffix."""


def line_up(name, number):
    """Return a formatted message containing the customer's ordinal position."""
    if 11 <= number % 100 <= 13:
        suffix = "th"
    else:
        suffix = {
            1: "st",
            2: "nd",
            3: "rd",
        }.get(number % 10, "th")

    return (
        f"{name}, you are the {number}{suffix} customer "
        "we serve today. Thank you!"
    )