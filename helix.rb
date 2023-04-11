# frozen_string_literal: true

module Helix
  keys = [
    {
      key: {
        unshifted: {
  
        },
        shifted: {
          alt: {
            
          },
          ctrl: {
            
          }
        }
      }
    }
  ]
end

module Helix
  def keymap
    %(
Q  W  F  P  B  J  L  U  Y  ;
A  R  S  T  G  M  N  E  I  O
Z  X  C  D  V  K  H  ,  .  /

q | Q - Play back a recorded macro                 | Start/stop macro recording
w | W - Move next word start                       | Move next WORD start
f | F - Find next char                             | Find previous char
p | P - Paste after selection                      | Paste before selection
b | B - Move previous word start                   | Move previous WORD start
j | J - Down                                       | Join lines inside selection
l | L - Select next search match                   | Select previous search match
u | U - Undo change                                | Redo change
y | Y - Yank selection                             | Nothing
; | ; - Collapse selection onto a single cursor    | Command mode
a | A - Insert after selection (append)            | Insert at the end of the line	
r | R - Replace with a character                   | Replace with yanked text
s | S - Select all regex matches inside selections | Split selection into sub selections on regex matches
t | T - Find 'till next char                       | Find 'till previous char
g | G - Goto mode                                  | Go to line number <n>
m | M - Match mode                                 | Nothing
n | N - Left                                       | Insert before selection
e | E - Down                                       | Open new line below selection
i | I - Up                                         | Open new line above selection
o | O - Right                                      | Insert at the start of the line
z | Z - View mode                                  | Sticky view mode
x | X - Expand line selection                      | Extend selection to line bounds
c | C - Change selection                           | Copy selection onto the next line
d | D - Delete selection                           | Nothing
v | V - Select (extend) mode                       | Nothing
k | K - Up                                         | Keep selections matching the regex
h | H - Left                                       | Move next word end
, | < - Keep only the primary selection            | Indent selection
. | > - Repeat last insert                         | Unindent selection
/ | ? - Search for regex pattern                   | Search for previous pattern
    )
  end
end


