#lang pollen

◊(require pollen/pagetree)
◊(require racket/symbol)

◊(define (node-link node)
   (let* ([node-string (symbol->immutable-string node)]
          [link-name (select-from-metas 'title node)]
          [link-date (select-from-metas 'date node)])
     (if node
         ◊post-item[link-date node-string]{◊link-name}
         "")))
◊(define (construct-posts-toc plist)
   (if plist
       (apply post-list (map node-link plist))
       ""))

◊(define posts-list (children 'posts.html (get-pagetree "index.ptree")))
◊(construct-posts-toc posts-list)
