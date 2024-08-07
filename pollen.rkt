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

;; TODO: Figure out how to get these footnotes to work
;; (define (root . elements)
;;   `(root ,@elements ,(footnote-block)))


;; tags for primary page
(define title (default-tag-function 'h1))
(define headline (default-tag-function 'h2))
(define (portrait source alt-text) `(img ((src ,source)(alt ,alt-text)(class "portrait"))))
(define link-block (default-tag-function 'div #:class "link-block"))

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

;; ===
(define (fn-id x) (string-append x "_fn"))
(define (fnref-id x) (string-append x "_fnref"))

(define fn-names null)
(define (fn name-in)
  (define name (format "~a" name-in))
  (set! fn-names (if (member name fn-names) fn-names (cons name fn-names)))
  `(sup (a ((href ,(string-append "#" (fnref-id name)))
            (id ,(fn-id name)))
           ,(format "(~a)" (length fn-names)))))

(define fndefs (make-hash))
(define (fndef name . xs) (hash-set! fndefs (format "~a" name) xs))

(define (footnote-block)
  (define note-items
    (for/list ([fn-name (in-list (reverse fn-names))])
              `(li ((id ,(fnref-id fn-name)))
                   ,@(append
                      (hash-ref fndefs fn-name)
                      (list `(a ((href ,(string-append "#" (fn-id fn-name)))) "↩"))))))
  `(section ((class "footnotes")) (ol ,@note-items)))
