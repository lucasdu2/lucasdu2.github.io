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

◊footer{made with robotic indifference -_- (with help from ◊link["https://docs.racket-lang.org/pollen/index.html"]{pollen})
 杜承旸 / lzdu ∊ ucdavis / ◊link["https://github.com/lucasdu2"]{GitHub} / ◊link["https://linkedin.com/in/lucaszdu"]{LinkedIn}

◊link["https://www.recurse.com/scout/click?t=ff3a1c13d455733bc31c3dd5ec3d1cf4"]{◊image["assets/rc-icon.png" "Recurse Center logo" "20em"]}}
