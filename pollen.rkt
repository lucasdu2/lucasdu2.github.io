#lang racket/base

(require pollen/decode pollen/misc/tutorial txexpr)
(require pollen/tag)
(require pollen/unstable/pygments)
(require pollen/pagetree)
(provide (all-defined-out))
(provide highlight)
(provide root)

(define (root . elements)
   (txexpr 'root empty (decode-elements elements
     #:txexpr-elements-proc decode-paragraphs
     #:string-proc (compose1 smart-quotes smart-dashes))))

;; tags for primary page
(define title (default-tag-function 'h1))
(define headline (default-tag-function 'h2))

(define email (default-tag-function 'mark 'em))
(define (portrait source alt-text) `(img ((src ,source)(alt ,alt-text)(class "portrait"))))

;; some post-specific tags
(define post-title (default-tag-function 'h1))
(define post-section (default-tag-function 'h2))
(define post-date (default-tag-function 'p #:class "post-date" 'post-date))
(define (post-item p-date url text) `(li ((class "post-item")) (date-marker "[",p-date "]") " " "—" " " (a ((href ,url)(class "post-link")) ,text)))
(define post-list (default-tag-function 'ul #:class "post-list"))

;; general tags and functions
(define items (default-tag-function 'ul))
(define item (default-tag-function 'li))
(define (link url text) `(a ((href ,url)(target "_blank")(rel "noopener noreferrer")) ,text))
(define divider '(hr))
