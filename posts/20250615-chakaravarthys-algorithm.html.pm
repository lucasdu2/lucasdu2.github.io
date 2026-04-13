#lang pollen

◊(define-meta title "Chakaravarthy's algorithm")
◊(define-meta date "Monday July 28, 2025")

◊post-title{◊(select-from-metas 'title metas)}
◊post-date{◊(select-from-metas 'date metas)}

Thankfully, spring quarter is over and summer is here!◊fn[0.5] This past quarter was pretty rough—I think I took one class too many, so even though all my classes were really cool, there were moments of real misery.◊fn[1] Many moments, actually. The bright side, of course, is that now I have fewer classes to take until I finish up the MS degree. ツ

◊em{Edit: I started writing this on June 15, which was right after school ended. But finishing the whole thing ended up taking a bit longer.}

◊fndef[0.5]{Having summer break is one the great perks of being in school.}
◊fndef[1]{In hindsight though, I still think it was the right decision. The classes were all very interesting, and (I think are) usually only offered in the spring. I'd rather be miserable this spring than next spring! Plus all the classes next quarter look boring, so I'm glad I knocked out more of my credits this school year.}
◊post-section{Points-to analysis}
One of my classes this quarter was ◊link["https://cs.ucdavis.edu/schedules-classes/ecs-240-programming-languages"]{ECS240: Programming Languages}, which was primarily focused on static analysis—specifically, basic dataflow analysis and abstract interpretation.◊fn[2] Something that I found quite cool was this algorithm for ◊em{polynomial-time} and ◊em{precise} flow-insensitive points-to analysis of ◊em{typed} programs, which was introduced in a 2003 POPL paper called ◊link["https://dl.acm.org/doi/abs/10.1145/640128.604142"]{"New Results on the Computability and Complexity of Points-to Analysis"}.

◊fndef[2]{It's pretty funny how many different things a class titled "Programming Languages" can cover. I would usually expect (and probably prefer) a core/required class focused on programming languages to cover "foundational" programming language theory, i.e. things like lambda calculus, type systems and basic results there, semantics, Hoare logic, and so on, but then there's this whole body of material on what could maybe be called ◊em{implementation theory}—things related to compiler optimization, static analysis (particularly of programs in existing languages), garbage collection, etc. that are also really interesting and valid directions a course on programming languages can take.}

There are lots of other goodies about some of the theoretical boundaries of various classes of points-to analysis (the title is very apt!), but this algorithm—sometimes called ◊strong{Chakaravarthy's algorithm} (after the paper's sole author: ◊link["https://pages.cs.wisc.edu/~venkat/"]{Venkatesan Chakaravarthy})—is particularly interesting. There really just aren't that many algorithms for non-trivial program analysis that are ◊em{polynomial-time}, i.e. ◊em{very fast}! It's also very nice that ◊em{types} (if only a very limited notion of types) are what makes it all possible.

◊aside{The algorithm feels a bit underappreciated, particularly since ◊em{precise} flow-insensitive points-to analysis in the ◊em{untyped} setting is known to be $\mathcal{NP}$-hard, which is much, much worse from a pure complexity standpoint. It's probably because Andersen-style pointer analysis, a sound and practically good-enough approximation of the precise analysis, has become so fast and practical (for example, see ◊link["https://hardekbc.github.io/files/hardekopf07ant.pdf"]{"The Ant and the Grasshopper"} by Hardekopf and Lin from PLDI 2007), and is maybe also easier to teach and compare alongside Steensguard's algorithm, another common◊fn[3] algorithm for (approximate, untyped, flow-insensitive) pointer analysis.}

◊fndef[3]{I actually don't know how "common" any of these algorithms are, although Steensguard is ◊link["https://releases.llvm.org/8.0.0/docs/AliasAnalysis.html#the-steens-aa-pass"]{definitely available in LLVM} and I believe lots of current research on this sort of pointer analysis is Andersen-style.}

That said, I honestly don't think the paper does a great job explaining the algorithm, particularly due to (1) some weird organizational quirks that are perhaps due to an effort to present formal complexity proofs alongside the algorithm structure and (2) some unfortunate typos.◊fn[3] So here's an attempt at going over the algorithm in a way that feels clearer to me. The full details remain in the paper itself—we only aim to give a better sense of the ◊em{structure of} and ◊em{general intuition behind} the algorithm.

◊fndef[3]{Also some math paper-y proofs that rely on some claim of obviousness, i.e. "It is clear that $G'$ is also layered" or "It is easy to see that the algorithm runs in polynomial time." Some of these may indeed be relatively obvious, but I still wish fewer papers would do this and at least sketch the ideas of the proof or give some brief intuition.}

Before we get into the algorithm itself though, let's pin down—roughly, at least—what we mean by ◊em{precise flow-insensitive points-to analysis}:
◊ol{
  ◊li{◊strong{points-to analysis:} Points-to analysis is a classic problem in static code analysis; it asks the question, "Given a program and two variables $p$ and $q$, can $p$ point to $q$ in some execution of the program?" Knowing what variables can point to what other variables is important for various ◊em{compiler optimizations}, as well as for other static analyses like ◊link["https://en.wikipedia.org/wiki/Constant_folding"]{constant-propagation}.

Importantly, if we know that $p$ ◊em{cannot} point to $q$, then we gain a guarantee of "separation"—$p$ and $q$ must refer to disjoint locations in memory—that allows us to show the ◊em{safety} of certain compiler optimizations or improve the ◊em{precision} of other static analyses. As a simple example of a compiler optimization that having sound points-to knowledge unlocks, consider this scenario: if we know that no other variables in our program point to $q$ and $q$ is assigned some constant integer like $3$, we can pre-compute an arithmetic expression like $q + 2$ at compile time (the expression will always evaluate to $5$), thus speeding up execution at runtime.}
  ◊li{◊strong{flow-insensitive:} Flow-insensitive points-to analysis is a slightly relaxed version of the points-to problem, where we consider programs as ◊em{sets of statements} (i.e. the statements have no notion of ordering corresponding to a control-flow graph of the program). We are allowed to execute the statements in our set ◊em{in any order} and statements can be executed ◊em{multiple times} (regardless of how many times it actually appears in our program). Note that the dual of this analysis, ◊em{flow-sensitive} points-to analysis, does take into account the ordering of statements given by a control-flow graph of the program.

Why do we take this relaxed and less precise view of the problem? The simple answer is that flow-sensitive points-to analysis is ◊em{very computationally expensive} to perform on programs of realistic size. So we have to compromise! And flow-insensitive points-to analysis turns out to still be useful enough in practice.}
  ◊li{◊strong{precision:} When we talk about an algorithm that gives us ◊em{precise} flow-insensitive points-to analysis, we mean an algorithm that gives us ◊em{exactly} the set of points-to relations for which there exists some sequence of program statements (under our relaxed, flow-insensitive formulation of the points-to problem) that ◊em{realizes} each relation.

Unfortunately, in the general case, precise flow-insensitive analysis is still relatively expensive—in fact, it's known to be $\mathcal{NP}$-hard! As a result, commonly used points-to algorithms—like those proposed by Andersen or Steensguard—are actually just sound/safe ◊em{approximations}, i.e. they include all the points-to relations in the precise set, but may also contain some extra relations.}
}

◊post-section{Chakaravarthy's algorithm}
We begin by giving some intuition on why the algorithm enjoys such good algorithmic complexity while still being precise, as well as a high-level view of its structure. We then fill in some of the details of this general outline, using the various definitions and pieces of intuition we've provided. We conclude with a brief sketch of the complexity argument.

◊post-subsection{General intuition}
The key to the algorithm is the observation that, by restricting ourselves to well-typed pointers, our pointers form a ◊em{layered graph} with certain good properties around ◊em{forbidden pairs}.

◊strong{First, what do we mean by ◊em{well-typed} pointers?}
We mean that we are restricting ourselves to a model where all:
◊ol{
  ◊li{variables have well-defined types, i.e. ◊code{int}, ◊code{int*}, ◊code{int**} in C-style pointer syntax, and}
  ◊li{pointers are well-typed in the sense that ◊em{a variable can only point to other variables of a compatible type}, i.e a variable of type ◊code{int**} can ◊em{only} point to a variable of type ◊code{int*}.}
} 
In this model (a model that seems quite reasonable, frankly), we can further simplify our notation by simply tracking the number of dereferences ◊code{*} that a variable's type has. For example, we say that a variable with type ◊code{int**} has the corresponding type $2$, the variable with type ◊code{int****} has the corresponding type $4$.

Intuitively, this simplification is fine since we can split any program into independent sets of statements that ◊em{only} include one base type (i.e. ◊code{int} or ◊code{string}) and analyze each of those sets separately, since all pointers must be well-typed (and so a ◊code{int} pointer can never point to a ◊code{string}, vice-versa, et-cetera).

Additionally (◊strong{and importantly}), this also restricts the ◊em{kinds of program statements} we need to consider. In fact, we only consider two kinds of statements:
◊items{
  ◊item{Statements of the form ◊code{*(d)p = &z}}
  ◊item{and statements of the form ◊code{*(d1)p1 = *(d2)p2}.}
}

◊strong{Second, why does this mean that our realizability graph is ◊em{layered}?}
Define our layers as follows: a variable of type $1$ is in layer $1$, a variable of type $2$ is in layer $2$, and so on. In a realizability graph, realizable points-to relations are edges between variables (where an edge from variable $a$ to variable $b$ means that $a$ can ◊em{point-to} $b$).

Given our requirement that all pointers are well-typed, note that our graph then has the following properties:
◊items{
  ◊item{Any edge in our realizability graph ◊em{must be} from layer $i$ to layer $i-1$. This is the ◊em{layering} property.}
  ◊item{Our realizability graph must also be ◊em{acyclic}, as a consequence of the layering property and the fact that all our variables must have well-defined types (so a variable cannot simultaneously have more than one valid type).}
}

◊strong{Finally, what are ◊em{forbidden pairs}, why are they a problem, and how do our types help?}
Forbidden pairs are also called ◊em{dependencies} in the paper, which is slightly confusing. Very briefly, ◊em{forbidden pairs} are basically two points-to relations (or edges, in the visual terminology of our realizability graph) that ◊em{cannot be simultaneously realized}.

Such forbidden pairs are the ◊strong{crux of the difficulty} in getting ◊em{precise} analysis in the general case, i.e. in the untyped setting that analyses like Andersen's algorithm operate in. In an algorithm like Andersen's, we have no easy way of tracking such forbidden pairings/dependencies. So a ◊strong{points-to relation} computed by Andersen's algorithm ◊strong{that relies on two relations in a forbidden pair} ◊em{is allowed}, even though that relation is actually ◊em{unrealizable} (i.e. because the two points-to relations in the forbidden pair are not simulateously realizable, there actually is no sequence of statements that can actually realize the computed points-to relation that relies on the forbidden pair).

◊aside{As a brief example, say we have some statement ◊code{d = *a} and two points-to relations already in our points-to set: $\langle a, b \rangle$ and $\langle b, c \rangle$. In Andersen's algorithm, this set of conditions allow us to conclude that $\langle d, c \rangle$.◊fn[3.1] However, say that $\langle a, b \rangle$ and $\langle b, c \rangle$ are in a forbidden pair and are thus not realizable simultaneously. This means that $\langle d, c \rangle$ is actually ◊em{not realizable}, but since there's no easy way to compute and track these sorts of forbidden pairs in the untyped setting, Andersen's algorithm will just let this slide (and accept the resulting imprecision).}
◊fndef[3.1]{For reference, take any inference rule style presentation of Andersen's algorithm, which should be accessible with a quick web search or LLM query 🙃}

This is the source of the imprecision of such algorithms: we will compute certain points-to relations for which there is actually no sequence of statements demonstrating realizability. These relations end up being the "extra" relations mentioned earlier.

Getting the truly precise set of points-to relations involves ◊em{an efficient method of computing and tracking forbidden pairs}. Thankfully, our well-typed pointers and the resulting layered realizability graph gives us such a method. More specifically, ◊strong{our layered realizability graph has the following nice property} regarding forbidden pairs:
◊items{
  ◊item{Edges (in other words, points-to relations) in different layers can ◊em{never be dependent} (in other words, can never be in a forbidden pair together). As a note on the definition of the ◊em{layer} of an edge: an ◊em{edge} in our graph $\langle a,b \rangle$ where $a$ is in layer $l$ and $b$ is in layer $l-1$ is said to be in layer $l$.}
}
This simplifies things greatly, since ◊strong{forbidden pairs of points-to relations can ◊em{only} occur when they are in the ◊em{same layer} of our realizability graph}, i.e. edges can only be dependent when they are in the same layer. This gives us an efficient way of computing, tracking, and avoiding such forbidden pairs in the typed setting , helping us keep the algorithm in polynomial time.

◊post-subsection{Algorithm structure}
The algorithm proceeds ◊em{top-down}, in ◊em{one pass}, through our layered graph structure, starting at the top layer $L$ (the layer containing the largest types) and moving down. We construct the edges in the graph and add to the graph's metadata (i.e. our set of ◊em{forbidden pairs}) dynamically as we move down the layers. We will need the information from prior layers to perform the algorithm at the current layer.

◊aside{Specifically, we assume by induction that all edges and forbidden pairs from layer $L$ (the top layer) to $l+1$ (the preceding layer) have already been correctly computed, since the algorithm at each layer relies on this being the case.}

At each layer $l$, the algorithm proceeds in 4 stages. The first two stages prepare the information necessary for the final two stages, which are the ones that actually compute the new edges and the set of forbidden pairs of edges in the current layer. Here are what each of the 4 stages ◊em{should do}, in brief:

◊ol{
  ◊li{◊underline{Direct assignments:} Take statements of the form ◊code{*(d)p = &z}, where ◊code{*(d)p} means ◊code{d} number of dereferences ◊code{*} before ◊code{p}. Find the variables ◊code{q} in layer $l$ that can be made to point to ◊code{z} by this statement. ◊code{q} can be made to point to ◊code{z} ◊strong{iff} there exists a path from ◊code{p} to ◊code{q} in our realizability graph so far. Note that, for this to work, ◊code{z} must be in layer $l-1$ and ◊code{p} must be in layer $l+$◊code{d}.} 
  ◊li{◊underline{Copying statements:} Take statements of the form ◊code{*(d1)p1 = *(d2)p2}. For any two pointers ◊code{q1} and ◊code{q2} in layer $l$, the idea is that such a statement can ◊em{copy} values of ◊code{q2} to ◊code{q1} if ◊em{there is a path from ◊code{p1} to ◊code{q1} and a path from ◊code{p2} to ◊code{q2}}, such that the paths are (a) ◊em{vertex disjoint} and (b) ◊em{contain no forbidden pairs between them}. Find all these pairs ◊code{(q1,q2)} in layer $l$ such that the value of ◊code{q2} can be copied to ◊code{q1}.}
  ◊li{◊underline{Edge computation:} Compute the edges in the current layer using the pairs from the ◊underline{direct assignments} and ◊underline{copying statements} phases.}
  ◊li{◊underline{Forbidden pair computation:} Compute the forbidden pairs of edges in current layer, again using the pairs we've already computed in the ◊underline{direct assignments} and ◊underline{copying statements} phases.}
}
Importantly, each of these stages can be modelled as a certain sub-problem with a polynomial time algorithmic solution. Here are each of the stages mapped onto their particular sub-problem—these sub-problems get us from what the stages ◊em{should do} to an idea of ◊em{how to do them}:
◊ol{
  ◊li{◊underline{Direct assignments:} the ◊strong{graph reachability} problem on the realizability graph at that point.}
  ◊li{◊underline{Copying statements:} the ◊strong{disjoint paths with forbidden pairs} problem on the realizability graph at that point.}
  ◊li{◊underline{Edge computation:} the ◊strong{1-CCP (Concurrent Copy Propagation)} problem, using information produced by the ◊underline{direct assignments} and ◊underline{copying statements} phases.}
  ◊li{◊underline{Forbidden pair computation:} the ◊strong{2-CCP} problem, using information produced by the  ◊underline{direct assignments} and ◊underline{copying statements} phases.}
}

◊strong{Graph reachability} is relatively well-known (and can be implemented fairly simply, if naively, with some kind of bread-first or depth-first search), so we elide deeper discussion of the problem. It's also known to be solvable in at least ◊em{linear time}.◊fn[4] However, we will outline the ◊strong{disjoint paths with forbidden pairs} and ◊strong{CCP} problems below, along with informal arguments that they can be solved in polynomial time.
◊fndef[4]{Since BFS is technically linear time, for example, or more specifically $\mathcal{O}(|V|+|E|)$ for some graph $G = (V, E)$. Or an appeal to Wikipedia citations ◊link["https://en.wikipedia.org/wiki/Reachability#cite_note-4"]{here}.}

◊post-subsection{Disjoint paths with forbidden pairs}
While the usual disjoint paths problem (i.e. where the graph is not necessarily layered and there are no forbidden pairs) is $\mathcal{NP}$-complete, there exists an algorithm for our particular case—where we have a layered graph and each forbidden pair of edges is in the same layer—that is polynomial time. In particular, we are able to reduce the problem to ◊strong{reachability in directed graphs}, using a ◊em{polynomial time} reduction.

Here are the broad strokes of the algorithmic solution:
◊ol{
  ◊li{We take as input our layered graph $G=(V, E)$, with some layering function $l$, a pair of source vertices $(s1,s2)$, a pair of target vertices $(t1,t2)$, and a set of forbidden pairs $F$.}
  ◊li{We can assume (without loss of generality) that our source vertices are in the same layer and that the target vertices are also in the same layer. (The fact that this is safe is discussed in more depth in the paper.)}
  ◊li{We now construct a new graph $G'=(V',E')$ using $G$. Formally, we define:
    ◊ol{
      ◊li{$V'=\{\langle u,v \rangle\ |\ u,v\in V, u \neq v, l(u)=l(v)\}$}
      ◊li{$E'=\{(\langle u_1,v_1 \rangle, \langle u_2,v_2 \rangle)\ |\ (\langle u_1,u_2 \rangle, \langle v_1,v_2 \rangle) \in (E \times E) - F\}$}
    }
    This is a bit of a mouthful, so take some time to digest these definitions. In plainer words, our new $V'$ is a subset of $V \times V$ and consists of all pairs of distinct vertices in the same layer of $G$. The new "vertices" in $V'$ are connected by an "edge" in $E'$ if the ◊em{corresponding components of these vertices are connected by a pair of non-forbidden edges in $G$}.
  }
  ◊li{Now, for the most important bit: a given instance has a solution ◊strong{iff there is a path from $\langle s_1,s_2 \rangle$ to $\langle t_1,t_2 \rangle$ in $G'$}. As we foreshadowed earlier, this is just a graph reachability problem in a directed graph.}
}

The reduction is polynomial time, the size of $G'$ is polynomial in the size of $G$, and the resulting reachability problem can then also be solved in polynomial time (i.e. with depth-first search). We leave more formal arguments for the correctness of this reduction to the full paper.

◊post-subsection{Concurrent Copy Propagation (1- and 2-CCP)}
The general $k$-CCP problem can be described as follows. We are given a set of variables $V$, a set of constants $C$, and a set of statements $S$. We consider two types of statements: (1) ◊code{X := a} for some ◊code{X} in $V$ and some ◊code{a} in $C$; (2) ◊code{X := Y} for some ◊code{X} in $V$ and some ◊code{Y} in $V$. Executing a statement of type (1) ◊em{assigns the constant ◊code{a} to variable ◊code{X}}; executing a statement of type (2) ◊em{copies the current value of variable ◊code{Y} to ◊code{X}}.

Now, consider some set of goals $G$ that consists of pairs of variables and constants, i.e. ◊code{<X1,a1>,<X2,a2>,...<Xk,ak>}. Note that the ◊code{k} here is the same as the $k$ of our $k$-CCP problem (and is just some positive integer).

$G$ can be ◊em{realized} if there is some finite sequence of statements in $S$ such that, at the end of the sequence, all of our goals in $G$ are realized, i.e. the value of ◊code{X1} is ◊code{a1}, the value of ◊code{X2} is ◊code{a2}, ...the value of ◊code{Xk} is ◊code{ak}. (Note the parallels here to the points-to analysis that we are interested in solving!)

The solution $\lambda$ to $k$-CCP is the ◊em{set of all such realizable sets of $k$ goals}.

What's interesting about the $k$-CCP problem is that, when $k$ can be arbitrary (and part of the input to the problem), the decision version of the problem (i.e. can our set of goals $G$ be realized?) is PSPACE-complete, but when $k$ is constant, the problem is polynomial time. We are actually ◊strong{only interested in the cases where $k=1$ and $k=2$, so our problems have polynomial time solutions}.

For the 1-CCP problem, we can reduce it to a problem of reachability in directed graphs. More specifically, we can construct a graph where statements like ◊code{X := Y} are represented by an edge from some variable node ◊code{Y} to some variable node ◊code{X} and statements like ◊code{X := a} are represented by an edge from some constant node ◊code{a} to some variable node ◊code{X}. To check which variables can be assigned what constants, we simply need to check which variable nodes are reachable from what constant nodes in our graph.

For the 2-CCP problem, here's a sketch of the algorithmic solution, which takes the form of iterative transitive closure based on a set of rules:
◊ol{
  ◊li{We start with $\lambda = \{$ ◊code{{<X,x>,<Y,y>}}$\ |\ $ ◊code{X != Y} and ◊code{X := x}, ◊code{Y := y} are statements in $S\}$}
  ◊li{Then we simply iterate over our set of statements $S$, adding more elements to $\lambda$ until we reach a fixpoint. Our rules for adding elements are as follows. For each element in $\lambda$, ◊code{{<X,x>,<Y,y>}}:
    ◊ul{
      ◊li{for a statement of the form ◊code{Z := z}, where ◊code{Z != X}, add ◊code{{<X,x>,<Z,z>}} to $\lambda$}
      ◊li{for a statement of the form ◊code{Z := X}, where ◊code{Z != X}, add ◊code{{<X,x>,<Z,x>}} to $\lambda$}
      ◊li{for a statement of the form ◊code{Z := X}, where ◊code{Z != Y}, add ◊code{{<Z,x>,<Y,y>}} to $\lambda$}
    }
  }
}

 Note that the boundary condition here in which ◊code{X} is the only variable that gets a constant assigned to it directly must be handled separately. Again, we leave more formal details to the paper (although the paper also glosses over quite a bit of formal detail).

◊post-subsection{Filling in the details}
Now, armed with an idea of the general structure of the algorithm, we are ready to fill in some of the details. More specifically, how exactly do we implement each stage as an algorithmic solution to the sub-problems we've described? As a reminder, here are the sub-problems for each stage that give us an idea of ◊em{how to do} what we've said they ◊em{should do}:

◊ol{
  ◊li{◊underline{Direct assignments:} the ◊strong{graph reachability} problem on the realizability graph at that point.}
  ◊li{◊underline{Copying statements:} the ◊strong{disjoint paths with forbidden pairs} problem on the realizability graph at that point.}
  ◊li{◊underline{Edge computation:} the ◊strong{1-CCP (Concurrent Copy Propagation)} problem, using information produced by the ◊underline{direct assignments} and ◊underline{copying statements} phases.}
  ◊li{◊underline{Forbidden pair computation:} the ◊strong{2-CCP} problem, using information produced by the  ◊underline{direct assignments} and ◊underline{copying statements} phases.}
}

For ◊underline{direct assignments}, remember that we care about statements of the form: ◊code{*(d)p = &z}. We will use an algorithmic solution to ◊strong{graph reachability} in order to determine if some variable ◊code{q} in our current layer $l$ is reachable from ◊code{p} (in ◊code{d} steps). If so, then ◊code{q} can be made to point to ◊code{z} (and we can add the edge from ◊code{q} to ◊code{z}, although the algorithm described in the paper technically delays this until the ◊underline{edge computation} phase).

◊aside{Note that, by our inductive assumption, we have already computed all edges from layers $L$ to $l+1$ at this point and paths from any layer $>l$ ◊em{will only use edges from layers $>l$} (this is argued in more detail in the paper, but can sort of intuitively be seen as a corollary of the ◊em{layered} and ◊em{acyclic} properties of the realizability). Thus, we have all the information we need to solve graph reachability.}

For ◊underline{copying statements}, remember that we only care about statements of the form: ◊code{*(d1)p1 = *(d2)p2}. We will use the algorithmic solution to ◊strong{disjoint paths with forbidden pairs} to find all pairs ◊code{(q1,q2)} in layer $l$ such that there is a disjoint path, avoiding forbidden pairs, from ◊code{p1} to ◊code{q1} and ◊code{p2} to ◊code{q2} in our realizability graph so far.

◊aside{Again, by our inductive assumption, we have already computed all edges from layers $L$ to $l+1$, as well as all forbidden pairs of edges in each of those layers, so we have all the information we need to solve disjoint paths with forbidden pairs.}

For ◊underline{edge computation}, note that the previous two stages have given us: (1) pairs ◊code{<q,z>} such that ◊code{q} is in layer $l$, ◊code{z} is in layer $l-1$, and ◊code{q} can be made to point to ◊code{z}; and (2) pairs ◊code{(q1,q2)} such that values from ◊code{q2} can be copied to ◊code{q1}. We can then compute edges by solving the 1-CCP problem, where:
◊items{
  ◊item{the set of variables $V$ is the set of pointers in layer $l$ of our realizability graph, such that each pointer ◊code{q} in layer $l$ becomes a variable ◊code{Xq} in the CCP problem}
  ◊item{the set of constants $C$ is the set of pointers in layer $l-1$, such that each pointer ◊code{z} in layer $l-1$ becomes a constant ◊code{az} in the CCP problem}
  ◊item{each pair ◊code{<q,z>} identified by the ◊underline{direct assignments} stage adds statement ◊code{Xq := az} to the set of statements $S$ in the CCP problem}
  ◊item{each pair ◊code{(q1,q2)} identified by the ◊underline{copying statements} stage adds statement ◊code{X(q1) := X(q2)} to the set of statements $S$ in the CCP problem}
}
Each pair ◊code{<Xq,az>} in the solution to the 1-CCP problem as defined here corresponds to an edge ◊code{<q,z>} in the graph.

For ◊underline{forbidden pair computation}, the correspondence of pointers in the realizability graph and pairs identified by the ◊underline{direct assignments} and ◊underline{copying statements} stages to $V$, $C$, and $S$ in the CCP problem is the same. Each element ◊code{{<X(q1), c(z1)>, <X(q2), c(z2)>}} in the solution to the 2-CCP problem defined this way means that the pair of edges ◊code{<q1,z1>,<q2,z2>} ◊em{can be realized simultaneously}—every other pair of realizable edges in layer $l$ (as computed in ◊underline{edge computation}) is thus a ◊strong{forbidden pair}.

◊aside{At this point, all the pieces should be in place for an actual implementation of the algorithm, given a set of well-formed input statements!}

◊post-subsection{Missing formalism}
In our narrative here, we've avoided talking at all about any proofs of computational complexity in an effort to focus on a conceptual understanding of ◊em{how} the algorithm works (rather than ◊em{why} the algorithm is fast).

The interested reader should refer to ◊link["https://dl.acm.org/doi/abs/10.1145/640128.604142"]{the paper itself} for the proofs of the complexity of key components of the algorithm. That said, the paper itself also sweeps some truly rigorous formalism under the rug, particularly when tying all the pieces together at the end of Section 2. The enterprising student would perhaps be interested in working out the full inductive proofs! (I am not an enterprising student.)

◊aside{For what it's worth, the hand-wavy argument for polynomial time complexity is basically as follows: (1) the number of layers is linear to the size of the input (i.e. the set of well-formed program statements we get); (2) at each layer, there are 4 stages, each of which can be completed in polynomial time; (3) thus each layer can be completed in polynomial time, (4) meaning the entire algorithm is polynomial time. Finally, (5) all points-to relations (i.e. the point of the algorithm) can simply be read off the graph resulting from the algorithm in constant time, since they are just the edges.}
