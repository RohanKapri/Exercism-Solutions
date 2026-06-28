type LaserInfo = {
  x: number
  y: number
  angle: number
}

type PrismInfo = {
  id: number
  x: number
  y: number
  angle: number
}

const MAX_DISTANCE_FROM_RAY = 0.11
const FORWARD_EPS = 1e-9

function normalizeAngle(angle: number): number {
  let normalized = angle % 360
  if (normalized < 0) {
    normalized += 360
  }
  return normalized
}

export function findSequence(
  start: unknown,
  prisms: unknown,
): unknown {
  const laser = start as LaserInfo
  const crystalPrisms = prisms as PrismInfo[]

  const sequence: number[] = []

  let currentX = laser.x
  let currentY = laser.y
  let currentAngle = laser.angle

  while (true) {
    const angle = normalizeAngle(currentAngle)
    const radians = (angle * Math.PI) / 180

    const directionX = Math.cos(radians)
    const directionY = Math.sin(radians)

    let nextPrism: PrismInfo | null = null
    let bestDistance = Number.POSITIVE_INFINITY

    for (const prism of crystalPrisms) {
      const vectorX = prism.x - currentX
      const vectorY = prism.y - currentY

      const cross =
        directionX * vectorY - directionY * vectorX

      if (Math.abs(cross) > MAX_DISTANCE_FROM_RAY) {
        continue
      }

      const dot =
        directionX * vectorX + directionY * vectorY

      if (dot <= FORWARD_EPS) {
        continue
      }

      if (dot < bestDistance) {
        bestDistance = dot
        nextPrism = prism
      }
    }

    if (nextPrism === null) {
      break
    }

    sequence.push(nextPrism.id)
    currentX = nextPrism.x
    currentY = nextPrism.y
    currentAngle += nextPrism.angle
  }

  return sequence
}