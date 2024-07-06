#lang racket/base
(require pollen/decode pollen/misc/tutorial txexpr)
(require pollen/tag)
(provide (all-defined-out))
(provide root)

(define (root . elements)
   (txexpr 'root empty (decode-elements elements
     #:txexpr-elements-proc decode-paragraphs
     #:string-proc (compose1 smart-quotes smart-dashes))))

(define title (default-tag-function 'h1))
(define headline (default-tag-function 'h2))
(define items (default-tag-function 'ul))
(define item (default-tag-function 'li 'p))
(define (link url text) `(a ((href ,url)) ,text))
(define email (default-tag-function 'mark 'em))
(define (portrait source alt-text) `(img ((src ,source)(alt ,alt-text)(class "portrait"))))
