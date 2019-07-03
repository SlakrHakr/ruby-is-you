# atoms can be words or items
# { symbol: '#', name: 'grass', type: 'item', colors: [FG_GREEN, BG_BLACK], location: [20, 12] },
# { symbol: 'R', name: 'ruby', type: 'noun', colors: [FG_RED], location: [10, 10] },

# there's no reason a concept shouldn't have both implementation and representation
{ name: 'skull', symbol: 'S', tile: '%', type: 'noun', colors: [FG_RED] }
{ name: 'is', symbol: nil, tile: 'I', type: 'copula', colors: [FG_WHITE, BG_BLACK] }
{ name: 'kill', symbol: nil, tile: 'K', type: 'adjective', colors: [FG_RED] }

# YOU directs the keyboard input to the noun referenced
# PUSH SYSTEM:
#   PUSH applies push logic to the referent
#   STOP applies the stop rule of push logic to the referent
# KILL makes the referent delete a YOU that comes in contact with it
#   - when there are no YOU tiles remaining the session is over
# SINK makes the referent delete a YOU that comes in contact with it unless the referent is float
# HOT makes the referent delete a MELT that comes in contact with it unless the referent is float

# RULES
# A clause consists of a three-tile configuration of shape
#                               A
#                        ABC or B
#                               C
# where A is a noun, B is the copula IS, and C is either a noun (conversion)
#   or an adjective (rule registration)
# Every tick, each copula instance checks for locally valid clause configurations on it,
#   then registers that rule for that tick only
# Idea: rules are implemented as an adjacency matrix of reactions, e.g.
#
#        YOU_ MELT KILL PUSH SINK HOT_ WIN_ STOP MOVE
# s YOU_  n    n    n    n    n    n    win  stp  n
# u MELT  n    n    n    n    n    del  n    n    n
# b KILL  del  n    n    n    n    n    n    n    n
# j PUSH  psh  n    n    psh  del  n    n    stp  psh????
# e SINK  del  n    n    del  n    n    n    n    n
# c HOT_  n    n    n    n    n    n    n    n    n
# t WIN_  n    n    n    n    n    n    n    n    n
#   STOP  n    n    n    n    n    n    n    n    n
#   MOVE  n    n    n    n    n    n    n    stp  n
