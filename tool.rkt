#lang racket/base
(require drracket/tool
         racket/class
         racket/gui/base
         racket/unit
        ; mrlib/switchable-button
         framework
         (prefix-in lex: "lexer.rkt"))
(provide tool@)

;Set the editing colors
(define color-prefs-table
  `([comment ,(make-object color% 194 116 31) ,"comment"]
    [default ,(make-object color% "black") ,"default"]))


;; short-sym->pref-name : symbol -> symbol
;; returns the preference name for the color prefs
(define (short-sym->pref-name sym) (string->symbol (short-sym->style-name sym)))

;; short-sym->style-name : symbol->string
;; converts the short name (from the table above) into a name in the editor list
;; (they are added in by `color-prefs:register-color-pref', called below)
(define (short-sym->style-name sym)
  (case sym
    [('double-semi) "tex:syntax-coloring:scheme:operator"]
    [else (format "tex:syntax-coloring:scheme:~a" sym)]))

(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)
    
    (define tab-mixin
      (mixin (drracket:unit:tab<%>) (drracket:unit:tab<%>)
        
        
        (super-new
         (get-token lex:get-token)
         (token-sym->style short-sym->style-name)
         ) ; end super new
        )) ; end define text-mode-mixin
    
    
    
    
    (define (phase1) (void))
    (define (phase2) (void))
    
   
    (drracket:get/extend:extend-tab tab-mixin)
    ))

