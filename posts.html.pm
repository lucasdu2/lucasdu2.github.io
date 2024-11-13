#lang pollen

◊(require pollen/pagetree)
◊(require racket/symbol)

◊(define (node-link node)
   (define node-string (symbol->immutable-string node))
   (define link-name
     (let* ([name (car (select-from-doc 'h1 (get-doc node-string)))])
       name))
   (define link-date
     (let* ([date (car (select-from-doc 'post-date (get-doc node-string)))])
       date))
   ◊post-item[link-date node-string]{◊link-name})

◊(define posts-list (children 'posts.html (get-pagetree "index.ptree")))
◊(define (construct-posts-toc plist)
   ◊(if plist
        (apply post-list (map node-link plist))
        ""))

A chronologically ordered set of (somewhat) publishable thoughts, focused generally on the programming∧computer science∧research part of me.
◊(construct-posts-toc posts-list)
