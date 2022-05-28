import std/[hashes]

type
  StrView* = object
    src: ptr string
    a, b: int
    hash: Hash

proc initStrView*(s: var string): StrView =
  result.src = addr s
  result.a = 0
  result.b = s.len - 1
  result.hash = hash(s)

proc hash*(sv: StrView): Hash =
  result = sv.hash !& hash(sv.a) !& hash(sv.b)
  result = !$ result

template `$`*(sv: StrView): untyped =
  sv.src[][sv.a..sv.b]

template substr*(sv: StrView, start, last: int): untyped =
  StrView(src: sv.src, a: sv.a+start, b: sv.a+last)

template substr*(sv: StrView, start: int): untyped =
  StrView(src: sv.src, a: sv.a+start, b: sv.b)

template find*(sv: StrView, sub: char|string, start: Natural = 0): untyped =
  sv.src[].find(sub, start+sv.a, sv.b)-sv.a

#template find*(sv:StrView, sub:char|string, start:Natural, last:Natural):untyped =
#  sv.src[].find(sub, start+sv.a, last+sv.a)-sv.a
