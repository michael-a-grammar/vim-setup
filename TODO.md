!  - Shell command
'  - Resume picker
\* - Grep w/input (cwd)
,  - Buffers (cwd)
/  - Grep (cwd)
;  - Comment linewise w/operator
<  - Buffers
  - Find files (cwd)
󰌒  - Last buffer
F  - Forwards
l  - Locate file within Fern
L  - Toggle Fern
P  - Backwards

a  - Apps
b  - 
c  - Code
d  - Hop
e  - Edit
f  - Buffer
     / - Fuzzy find
     e - Diagnostics (Trouble)
     f - File
       e - File name w/o extension
       n - File name
         c - Copy to clipboard
         i - Insert
       r - Full path
       p - 

     s - Document symbols
     o - Symbols outline
     g - Git
       d - Diff
       e - Blame
       h - Hunks
       l - Logs
       r - Revert
     r - Treesitter
     Diagnostics (Telescope)
     u - Undotree

g  - Git
h  - History
i  - Slime
j  - 
k  - Toggles
m  -  
n  - Navigation
o  -
p  - Yank ring
q  - Quit
r  - 
s  - Search
t  - Buffers
u  -
v  -
w  - Windows
x  - 
y  - Tabs
z  - Vim

Hop
Git
Plugins
Projects
Slime
Telescope
Terminal
Trouble
Symbols Outline


QWFP LUY;
ARST NEIO
ZXCD H,./

ST NE
T N

T - Buffers
N - Navigation

Merge Navigation and Find
N should be Buffer

TODO:

- Backspace should become hop
- Move opts from start into their own, seperate module
- Use elden as the API layer - bind plugin functions here
- Set up keymappings last
- use 'q' to quit most transient windows (help, fern etc.)
- autocommand to strip trailing whitespace (%s/\s\+$//e)
- micro - bundled plugin to enable better understanding of macros
- log (with tolerance)
- cmp / lsp config
- add delay to cmp command complete
- formalise rust workflow functions
- replace easy-motion with hop
- replace airline
- silence errors on sync
- use 'U' to redo
- use 'p' / 'P' for backwards and fowards
- use arrow keys to move windows
