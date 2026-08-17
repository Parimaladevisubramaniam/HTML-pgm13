#!/bin/bash
MARKS=0
pass(){ echo "TEST $1 PASS - $2 - 5 marks"; MARKS=$((MARKS+5)); }
fail(){ echo "TEST $1 FAIL - $2 - 0 marks"; }
CSS=$(cat c07x_speaker.css 2>/dev/null)
[ -f index.html ] && pass 1 "index.html found" || fail 1 "index.html missing"
[ -f c07x_speaker.css ] && pass 2 "CSS file found" || fail 2 "CSS file missing"
if grep -qi '<header' index.html && grep -qi '<main' index.html && grep -qi '<section' index.html && grep -qi '<article' index.html && grep -qi '<aside' index.html && grep -qi '<footer' index.html; then pass 3 "Required HTML structure found"; else fail 3 "Required HTML structure missing"; fi
if grep -qi 'Scott Sampson' index.html && grep -qi 'Guest speakers' index.html && grep -qi 'Fossil Threads in the Web of Life' index.html; then pass 4 "Required speaker content found"; else fail 4 "Speaker content missing"; fi
if echo "$CSS" | grep -Eiq 'a[[:space:]]*:[[:space:]]*link[[:space:]]*\{[^}]*color[[:space:]]*:[[:space:]]*(green|#008000)'; then pass 5 "a:link green"; else fail 5 "a:link green missing"; fi
if echo "$CSS" | grep -Eiq 'a[[:space:]]*:[[:space:]]*hover' && echo "$CSS" | grep -Eiq 'a[[:space:]]*:[[:space:]]*focus' && echo "$CSS" | grep -Eiq 'color[[:space:]]*:[[:space:]]*(fuchsia|#ff00ff)'; then pass 6 "a:hover and a:focus fuchsia"; else fail 6 "hover/focus fuchsia missing"; fi
if echo "$CSS" | grep -Eiq 'main[[:space:]]+p[[:space:]]*:[[:space:]]*first-child[[:space:]]*\{[^}]*font-weight[[:space:]]*:[[:space:]]*bold'; then pass 7 "first paragraph bold"; else fail 7 "first paragraph bold missing"; fi
if echo "$CSS" | grep -Eiq 'main[[:space:]]+p[[:space:]]*:[[:space:]]*first-child[[:space:]]*::first-letter[[:space:]]*\{[^}]*font-size[[:space:]]*:[[:space:]]*150%'; then pass 8 "first-letter 150%"; else fail 8 "first-letter 150% missing"; fi
if echo "$CSS" | grep -Eiq '^a[[:space:]]*\{[^}]*font-weight[[:space:]]*:[[:space:]]*bold'; then pass 9 "all hyperlinks bold"; else fail 9 "hyperlink bold missing"; fi
if grep -qi 'toobin' index.html && grep -qi 'sorkin' index.html && grep -qi 'chua' index.html && grep -qi 'mailto:' index.html; then pass 10 "Original links and mail link retained"; else fail 10 "Original links/mail link missing"; fi
echo "FINAL SCORE: $MARKS / 50"
[ "$MARKS" -eq 50 ] && exit 0 || exit 1
