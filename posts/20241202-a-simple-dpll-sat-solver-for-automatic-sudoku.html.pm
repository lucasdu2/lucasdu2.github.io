#lang pollen

◊post-title{A simple DPLL SAT solver for automatic Sudoku}
◊post-date{Monday December 2, 2024}

As part of my work at ◊link["https://www.recurse.com/"]{Recurse Center} recently, I wrote an extremely naive DPLL SAT solver in ◊link["https://racket-lang.org/"]{Racket} and used it to encode an automatic Sudoku solver. Using that code as a guide, here's an attempt at some longer-form exposition on the very basics of ◊strong{propositional logic} and ◊strong{automated logical reasoning}.

◊aside{By the way: Racket is a cool language, and you --- yes, you! --- should give it a try. It's a direct descendant of Scheme---in some ways, it is ◊em{just} Scheme with some extensions---and it has lots of parentheses. Don't be scared! You might like it! I think it is quite well designed and has good beginner support, along with a host of more advanced/interesting features.}

◊section{What is a SAT solver?}
A SAT solver, or a ◊strong{satisfiability solver}, is a program that automatically solves for the ◊em{satisfiability} of a ◊em{formula} in ◊em{propositional logic}. Let's go over the definitions of these terms, starting from the last one and moving backwards.

◊em{Propositional logic} is a logic that consists only of logical statements built up from ◊em{boolean variables} and your standard logical connectives: conjunction (and), disjunction (or), implication (implies), biconditional (if and only if), and negation (not). A boolean variable can either be ◊strong{true} or ◊strong{false}. There are certainly more technical definitions, but this should serve our purposes here.

A ◊em{formula} is simply some logical statement.

The ◊em{satisfiability} of a formula is the problem of determining whether there is an assignment to all the free variables in a formula (also called an ◊em{interpretation}) such that the formula is ◊strong{true}. If there is, the formula is ◊strong{satisfiable} (or SAT, in some lingo). If there isn't, the formula is ◊strong{unsatisfiable} (or UNSAT). Such an assignment --- one that makes the formula evaluate to ◊strong{true} --- is called a ◊em{model}.

Something very nice about propositional logic is that the satisfiability of formulae in it is ◊em{decidable}. ◊strong{Decidability} essentially means: ◊strong{there exists some algorithm (i.e. a mechanical procedure) that always terminates and always gives back a correct answer.}

This is pretty exciting --- it means that we can solve the satisfiability problem for propositional logic ◊em{automatically}, without needing to resort to human ingenuity. This is also what makes SAT solvers possible, from a theoretical perspective.

◊aside{SAT solvers form the basis of some more powerful, practical tools called SMT solvers (where SMT stands for satisfiability modulo theories). SMT solvers extend SAT solvers with ◊em{decidable theories} of first-order logic --- at a high level, this basically means that they can automatically solve logical formulae that include more advanced and more realistic things, i.e. integers, rational numbers, arrays, strings, and so on. We won't go into more detail about SMT solvers here.}

SAT solvers, in this sense, just implement some algorithm that decides the satisfiability of a propositional logic formula. The algorithm that most (if not all) modern SAT solvers are built on is named ◊strong{DPLL}, after its cited inventors: Martin Davis, Hilary Putnam, George Logemann, and Donald Loveland. DPLL operates only on propositional logic formula in ◊em{conjunctive normal form} (CNF).

Conjunctive normal form is a conjunction of ◊em{clauses}, each of which are a series of disjunctions. To make it a bit more concrete, here's the structure of a formula in CNF:
$$(A_1 \lor A_2 \lor \ldots) \land (B_1 \lor B_2 \lor \ldots) \land (C_1 \lor C_2 \lor \ldots) \land \ldots$$

DPLL is a fairly simple algorithm at heart --- we'll try and give a taste of it, in naive form.

◊aside{There are a large number of extensions and optimizations to classic, naive DPLL. We won't really cover them here. The most important one though, at least from a contemporary standpoint, is something called ◊strong{conflict-driven clause-learning (CDCL)}. The gist of CDCL is that, whenever we hit a ◊em{conflict} in DPLL (i.e. when we make an assignment that results in the formula being ◊strong{false}), we add a clause to the formula that ◊em{encodes the "why" behind the conflict}, so that we don't go down that path again. The specifics are too much for now.}

◊section{DPLL at its simplest}
DPLL is a ◊em{backtracking} search algorithm --- at its core, it guesses an assignment, propagates that assignment throughout the formula, guesses another assignment, and so on. If it ever hits a conflict, it backtracks to a previous stage before the conflict. Then it will make another best effort guess, and continue as before.

That said, DPLL has a bit of cleverness up its sleeve in the form of something called ◊strong{boolean constraint propagation (BCP)}, which is based on ◊strong{unit resolution}. The idea behind unit resolution is simple: if there is a ◊em{unit clause} --- a clause that ◊em{only has one literal in it} --- then we ◊em{must} assign the Boolean value that makes the literal in the unit clause true. This is called an ◊strong{implied assignment}.

◊strong{BCP} is just a fancy/concise name for the act of applying ◊strong{unit resolution} repeatedly, as much as possible.

◊aside{Here is an example of applying BCP to the formula: $(\lnot A) \land (A \lor \lnot B)$. The first clause is unit, implying the assignment "$A$ is ◊strong{false}." This produces $(\lnot B)$, which is also a unit clause implying the assigmnent "$B$ is ◊strong{false}." Thus, we have a satisfying assignment, where $A$ and $B$ are both ◊strong{false}.}

Besides BCP, DPLL is basically just a brute-force search algorithm. Whenever we can't apply BCP, we take some free variable in the formula, assign it an arbitrary Boolean value, and then see what happens (backtracking when we hit a conflict). Here is the algorithm, at a high level, in ML-like pseudocode:
◊highlight['ocaml #:python-executable "python3"]{
let rec DPLL F =
  let F' = BCP F in
  if F' = SAT then true
  else if F' = UNSAT then false
  else
    let P = CHOOSE_FREE_VAR F' in
    (DPLL (F' where P is true)) || (DPLL (F' where P is false))
}

◊section{Some implementation details}
There are a couple quick rules we can use to propagate an assignment (regardless of whether it's ◊em{implied} --- meaning that it results from unit resolution --- or ◊em{decided} --- meaning that it is a best-effort guess). They are:
◊ol{
  ◊li{If an assignment makes a literal in a clause ◊strong{true}, we can remove the entire clause from the formula without changing its satisfiability.}
  ◊li{If an assignment makes a literal in a clause ◊strong{false}, we can remove that literal from the clause without changing its satisfiability.}
}

There are two corresponding rules for determining if the end result of DPLL, implemented using the propagation rules above, is UNSAT or SAT. They are:
◊ol{
  ◊li{If we reach a point where there are ◊em{no clauses left}, the formula is SAT.}
  ◊li{If we reach a point where there is an ◊em{entirely empty clause} in the formula, the formula is UNSAT.}
}

Take a bit to think about why all these rules are true and how the first two relate to the second two. Also, here is some Racket code that implements the UNSAT/SAT determination described.

◊highlight['racket #:python-executable "python3"]{
;; If all clauses have been removed, we have SAT
(define (sat? f)
  (equal? f '()))
;; If any clause is empty, we have UNSAT
(define (unsat? f)
  (ormap (λ (clause) (equal? clause '())) f))
}

Now, here's a bit of Racket code that implements both the propagation logic and the overall BCP step of DPLL. Note that there are some differences from the pseudocode given earlier, primarily because we want to ◊strong{save our assignments}. It's nice to get a constructive satisfying assignment when a formula is satisfiable --- for example, it will let us get an actual solution to a Sudoku puzzle (as opposed to simply saying whether the puzzle can be solved).
◊highlight['racket #:python-executable "python3"]{
;; NOTE: sign must be a boolean (#t or #f). #f means negation. var should be
;; represented by an arbitrary positive integer.
(struct lit (sign var) #:transparent)

;; propagate-assignment takes an assignment to a variable and
;; propagates it throughout the formula using some simple rules.
(define (propagate-assignment var b-assign cnf)
  (define (propagate-iter in-cnf out-cnf)
    (if (empty? in-cnf)
        out-cnf
        (let ([cl (first in-cnf)]
              [xs (rest in-cnf)])
          (propagate-iter
           xs
           (if (findf (λ (l) (equal? l (lit b-assign var))) cl)
               ;; If the assignment results in a literal that evaluates
               ;; to TRUE, completely remove the clause
               out-cnf
               ;; Otherwise, remove matching lits from the clause
               ;; (but not the whole clause!)
               (cons
                (filter (λ (l) (not (equal? (lit-var l) var))) cl)
                out-cnf))))))
  (propagate-iter cnf '()))

;; bcp recursively finds a unit clause and then propagates the implication.
(struct bcp-results (cnf assignments))
(define (bcp cnf assignments)
  (define (search-for-unit)
    (findf (λ (clause) (= (length clause) 1)) cnf))
  (let ([found-unit (search-for-unit)])
    (if (not found-unit)
        (bcp-results cnf assignments)
        (let* ([l (first found-unit)]
               [v (lit-var l)])
          ;; NOTE: The implied variable assignment will always be (lit-sign l)
          (bcp
           (propagate-assignment v (lit-sign l) cnf)
           (cons (cons v (lit-sign l)) assignments))))))

}

The last piece we need is a way to choose a free variable to ◊em{decide} an assignment for, when we finish using BCP. This corresponds to the ◊code{CHOOSE_FREE_VAR} function in our ML-like pseudocode earlier. The simplest way to do this is just to choose the first free variable in the first clause of our formula. There are more elaborate and efficient ways to make this choice --- in fact, making smart choices here can lead to big speedups in SAT solving! --- but this simple choice will do for now.

◊highlight['racket #:python-executable "python3"]{
;; choose-unassigned-var naively takes the first variable in the CNF.
(define (choose-unassigned cnf)
  (lit-var (first (first cnf))))
}

Now, we can put it all together! Here's the Racket code for the DPLL function, using all the functions we've built up so far:

◊highlight['racket #:python-executable "python3"]{
(define (dpll cnf)
  (define (dpll-assignments cnf assignments)
    (let* ([res (bcp cnf '())]
           [res-cnf (bcp-results-cnf res)]
           [res-ass (bcp-results-assignments res)]
           [new-ass (append res-ass assignments)])
      (cond
        [(sat? res-cnf) new-ass]
        [(unsat? res-cnf) #f]
        [else
         (let ([p (choose-unassigned res-cnf)])
           (or
            (dpll-assignments (propagate-assignment p #t res-cnf)
                              (cons (cons p #t) new-ass))
            (dpll-assignments (propagate-assignment p #f res-cnf)
                              (cons (cons p #f) new-ass))))])))
  (dpll-assignments cnf '()))
}
◊section{Encoding the rules of Sudoku}
Something relatively simple and cool we can do with a SAT solver is use it automatically solve Sudoku puzzles. Is this particularly useful in practice? Not necessarily. But it's definitely fun to see the solver in action! At least I think so.

◊aside{There are ◊em{a lot} of practically useful applications of SMT solving (and SAT solving, by implication), particularly in the domains of programming languages and formal methods. ◊strong{It turns out that many problems in computational systems can be represented as satisfiability problems over some carefully crafted logical formulae!} SMT solvers can be leveraged in program verification tools (a la Dafny, Verus, etc.), program synthesis (i.e. VeriEQL, various applications of Rosette, etc.), distributed systems verification (a la lineage-driven fault injection), refinement-type checking (a la dsolve and Liquid Haskell), and so on. They are a powerful way to get ◊em{automatic} and ◊em{verifiably correct} answers to complex problems.}

We won't go over the details of the encoding here (an exercise for the reader!), but here are the high-level ideas and some starter code. We need to encode the following rules of Sudoku as propositional logic formulae in CNF form:
◊ul{
  ◊li{We must respect the initial configuration (the clues) of the board.}
  ◊li{Each cell must have ◊em{at least one} number.}
  ◊li{In each row/column/square (in a 9 by 9 board, squares are the smaller 3 by 3 sub-boards), a number can occur at most once.}
}

As a hint for the ◊em{at most once} constraint, think about ◊em{pairwise comparisons}. For example, let $A_i$ be a Boolean variable representing the statement "The number $1$ is placed in (row $0$, column $i$) of the Sudoku board." To encode the fact that the number $1$ can appear ◊em{at most once} in row $0$, we can represent it as a conjunction of disjunctions of all possible pairs in the row:
$$(\lnot A_1 \lor \lnot A_2) \land (\lnot A_1 \lor \lnot A_3) \land (\lnot A_1 \lor \lnot A_4) \ldots$$

Another potential difficulty is figuring out how to map logical statements like "the number $1$ is placed in (row $0$, column $5$) of the Sudoku board" to variables in our SAT solver, given that our variables are currently just represented by positive integers. There are various approaches to this (one might be to just have some hashmap that we maintain), but here's a clever-ish way to use arithmetic to get an encoding between specific guesses (logical statements) and variables (in our case, positive integers).

◊highlight['racket #:python-executable "python3"]{
(struct coord (row col) #:transparent)
(struct guess (row col num) #:transparent)

(define (encode-guess-as-var guess n)
  (let ([row (guess-row guess)]
        [col (guess-col guess)]
        [num (guess-num guess)])
    (+ num (* n (+ (* n row) col)))))

(define (decode-guess-as-var var n)
  (let* ([num (modulo var n)]
         [col (modulo (quotient var n) n)]
         [row (modulo (quotient (quotient var n) n) n)])
    (guess row col num)))

(define (get-var-from-coord-num c num n)
  (encode-guess-as-var (guess (coord-row c) (coord-col c) num) n))
}

◊section{Further references}
For further reading, there are a couple books that often get recommended (at least at the time of writing). Go crazy! Read them! They are:
◊ul{
  ◊li{The Calculus of Computation (Bradley and Manna, 2007)}
  ◊li{Decision Procedures: An Algorithmic Point of View (Kroening and Strichman, 2017)}
}
