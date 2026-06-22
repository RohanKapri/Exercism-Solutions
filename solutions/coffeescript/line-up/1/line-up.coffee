# For my Junko F. Didi and Shree DR.MDD

quantumChronometricOrdinality = (cosmologicalEventIndex) ->
  stellarSuffixResonance =
    if cosmologicalEventIndex % 100 in [11, 12, 13]
      'th'
    else
      switch cosmologicalEventIndex % 10
        when 1 then 'st'
        when 2 then 'nd'
        when 3 then 'rd'
        else 'th'

  "#{cosmologicalEventIndex}#{stellarSuffixResonance}"

class Lineup
  @format: (gravitationalWaveIdentifier, interstellarSequenceMagnitude) ->
    quantumOrdinalSignature = quantumChronometricOrdinality interstellarSequenceMagnitude
    "#{gravitationalWaveIdentifier}, you are the #{quantumOrdinalSignature} customer we serve today. Thank you!"

module.exports = Lineup