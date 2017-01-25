; it's not a safe change to make.
; Ben's new make-acount won't protect the acount
; when two same withdraw or deposit happen at
; the same time, because they are applyed by the
; same procedure during the operations.

; maybe because the implementation use a state variable
; to record the procedure operating on the target
; variable.
