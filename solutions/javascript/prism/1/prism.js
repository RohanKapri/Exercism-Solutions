const closeEnough = (a, b, tolerance = 0.00005) => Math.abs(a - b) < tolerance
const mod = (n, d) => ((n % d) + d) % d
const τ = Math.PI * 2

const getAngles = (cur, trgt) => 
  [cur.angle * (Math.PI / 180), Math.atan2(trgt.y - cur.y, trgt.x - cur.x)]

const isHit = (cur, trgt, [curΘ, trgtΘ] = getAngles(cur, trgt)) =>
  cur?.id != trgt.id &&
  (closeEnough(trgtΘ, curΘ) || closeEnough(mod(trgtΘ, τ), mod(curΘ, τ)))

const getClosest = (closest, hit) =>
  !closest || Math.hypot(closest.x, closest.y) > Math.hypot(hit.x, hit.y) ? hit
  : closest

const findHit = (cur, prisms) =>
  prisms.filter(trgt => isHit(cur, trgt)).reduce(getClosest, null)

export const findSequence = (cur, prisms, hits = [], hit = findHit(cur, prisms)) =>
  hit ? findSequence({ ...hit, angle: cur.angle + hit.angle }, prisms, [...hits, hit.id])
  : hits