export function format(name: unknown, number: unknown): unknown {
  const n = number as number
  const lastTwo = n % 100

  let suffix: string

  if (lastTwo >= 11 && lastTwo <= 13) {
    suffix = 'th'
  } else {
    switch (n % 10) {
      case 1:
        suffix = 'st'
        break
      case 2:
        suffix = 'nd'
        break
      case 3:
        suffix = 'rd'
        break
      default:
        suffix = 'th'
    }
  }

  return `${name}, you are the ${n}${suffix} customer we serve today. Thank you!`
}