#lang pollen

◊post-title{Tasteful debugging}
◊post-date{Wednesday August 21, 2024}

Let's put off doing more meaningful work and write down some quick thoughts I have about debugging, since they happen to be on my mind. All of this is just what I feel right now (and is subject to change)! But it's also something I feel strongly about and is a big part of what I want to do with my time at the moment.

◊post-section{Debugging is useless}
When you talk about debugging, anyone who's written any kind of computer program probably understands what you mean. It's likely the most relatable and most inevitable part of software development. Everyone debugs code. Most of software development is, in some sense, debugging. 

Debugging isn't really ◊em{useless} (after all, a bug fixed is a bug that can no longer hurt you...right?), but it does depend on what you're talking about when you talk about debugging.

There is an idealized sort of debugging that ◊em{is} actually useful and integral to the software development process. But most real-world debugging is not that. The bug finding and bug fixing process in software, particularly production software, often feels meaningless and pointlessly frustrating.

The problem isn't with the ◊em{idea} of debugging. The problem is that we need to make real-world debugging ◊em{better}.

The idealized scenario that people often reference when discussing debugging involves a kind of error where there is some ◊em{essential} misunderstanding about the program requirements, about some related system, or about the program itself that needs to be resolved. In these cases, there is something productive happening. You learn something, you get a bit better, perhaps, and the problem is, if you've properly understood things, fixed for good◊fn[1].

◊fndef[1]{Even in these cases though, our tools could do more to guide us in correcting these misunderstandings. Ideally, this correction would happen at the time of software construction. At the very least, we need fewer post-hoc, unprincipled fixes to things, something I believe our tools and abstractions can help us with.}

This kind of debugging is usually helpful---it's part of the mistake-feedback-learning loop that can make learning programming so fun and interactive. And this kind of debugging ◊em{is} inevitable and integral to the software development process. No one, no matter how excellent, will produce error-free code within an unfamiliar system. There is always a learning curve.

But most debugging in the real world, in my experience, is not like this. Many misunderstandings that lead to bugs are ◊em{not} about things that are essential, fundamental, or inevitable. Instead, they are results of historical accident. Debugging in real life often either:
◊items{
  ◊item{fixes the immediate problem, but results in more bugs and increasing cruft down the line or}
  ◊item{can't fully fix the bug because the bug is a result of a misaligned abstraction further down the stack, due to some unprincipled or ad hoc design decision in the system (that might be a bug fix for another, earlier, bug or just an arbitrary, best-guess choice by the system developers).}
}
Both these things suck. This kind of debugging is stupid and uninteresting. I want my solutions to solve the entire problem, from the bottom up. I want my solutions to last. And I want the source of the bug to be something foundational, something fundamental that I misunderstood. I don't want to deal with arbitrary hacks based on unsound, best-effort assumptions.

But how do we make this all better?

◊aside{There is a blog post by Allison Kaptur titled ◊link["https://akaptur.com/blog/2017/11/12/love-your-bugs/"]{"Love Your Bugs"} that I read a while back and that kicked off some thoughts on this general topic. I found the title of the post a little too saccharine (this probably says something about me that might...not be too great). After reading it, I actually did agree with some of what was said, particularly about how bugs can help you learn. That is certainly true, in the ideal (and, I would argue, uncommon) case. I still have issues with the general sentiment of the post---that you ◊em{should} love bugs, otherwise you aren't going to grow or be a good engineer. Bugs are often incredibly silly, wasteful, and lead to no tangible personal or intellectual growth (except maybe an increasing sense of resignation, which you could spin as "patience"). We don't have to love them. We often should (and could!) try to do better.}

◊post-section{A brief note on assumptions}

◊callout{Bugs are ◊em{not} a natural, fundamental reality of software.}

There are a number of assumptions in software engineering that I think a lot of practitioners, especially more experienced ones, hold. Some of these assumptions are, to me, a little frustrating. They constrict what people think is possible. They limit what people demand of their tools and their software. It's important, at least to me, to not conflate current reality with basic inevitability.

One assumption I wish we would abolish is that bugs are some kind of inevitable, natural law of software artifacts. I think the industry is far too accomodating of bugs---or mistakes, really---especially when it is simultaneously trying to push software into more important parts of our lives◊fn[2]. Software is, essentially, pure logic. There are no physical realities mandating the presence of bugs. Software by itself can, in theory, be a perfect, perpetual motion machine. That's part of its appeal.

◊aside{I saw a comment on HackerNews recently about the terrible mess that the Oracle Database codebase is in---a codebase that brings to mind a lot of the frustrations I have with debugging (and assumptions!) mentioned above---and a response that was essentially like, "OMG, what a great piece of engineering! I can't believe they can still add features and remain stable and underpin 90% of Fortune 500 companies." This is funny to me. I don't think this should impress you! This should scare you. This should scare you a lot. You don't have to accept your terrible reality◊fn[3]...and you certainly don't have to celebrate it.}

◊fndef[2]{To be totally fair though, human intent and execution are both fundamentally imperfect. While we should be less accepting of software bugs, we should still always strive to be kind to ourselves (and more generally, the human part of the process)! The answer to all of this is not to punish programmers more for making mistakes. Instead, it's to recognize that our tools should be helping us make fewer mistakes and to demand more of the software artifacts we produce and use.}

◊fndef[3]{OK, maybe this is a little too strident. Sometimes you do need to accept your reality, no matter how terrible, if you want to remain sane. But I do stand by my point that you don't need to celebrate it. That just feels like blatant Stockholm syndrome.}

◊post-section{What we (still) lack}

But we also need to be practical. Humans will, inevitably, make mistakes. What we need are tools, abstractions, and techniques to help us make far fewer mistakes about things that matter---ideally, none at all. In a sense, ◊em{we need ways to make debugging more pleasant and far more effective.}

There are multiple directions from which we can approach this. We should try and ◊strong{create as few bugs as possible} (during development---i.e. by-construction), we should try and ◊strong{surface bugs as quickly as possible} (especially if they make it into production), and we should ◊strong{make it much easier to fix bugs} when they surface.

I don't think I'm saying anything radical here, but I do believe that we need far more radical changes to the way we program in order to really accomplish these things in a way that is actually meaningful. We need to push forward both at a developer-facing level (with new products, startups, whatever) and at a deeper, more foundational, research level.

We need to stop pretending that we already know how best to program and that all we need are some superficial (and possibly LLM-based) tools to help us move faster in paradigms that we're already comfortable with. We don't need easier ways to make the same mistakes.

In particular, I believe we need the following:
◊items{
  ◊item{better fitting abstractions---ideally, mathematically principled abstractions---at a systems level, i.e. in the programming languages, databases, file systems, operating systems, etc. that we use (in general, we should aim to solve problems at their essence instead of piling on ad-hoc fixes over the top)}
  ◊item{stronger and broader ◊em{provable} guarantees about important program properties---program proofs should be far more common, starting with the foundational systems we use}
  ◊item{more principled, formal, and automated approaches to testing---i.e. fuzzing, concolic testing, property-based testing, etc.---that are interactive parts of software construction itself (not just something you do when things go wrong in production)}
}

There are some things being done along these lines in industry that I think are pretty cool. What ◊link["https://www.antithesis.com/"]{Antithesis} is doing with deterministic testing (which is an extension of the founders' previous work on FoundationDB's testing system) is awesome and pushes what's possible in automated testing and debuggability at scale. I like ◊link["https://www.instantdb.com/"]{InstantDB's} re-imagining of the database abstraction for client-side collaboration (and also their usage of Clojure!). But we can, and should, go much further. We should try to avoid ◊link["https://sourcegraph.com/blog/zig-programming-language-revisiting-design-approach"]{settling for local maxima}.

I'm personally very interested in mathematical approaches to these things. I really like the promise of things like program logics and type systems, both intellectually and practically---broadly, I think proofs and formal methods are the closest thing to a silver bullet that we have. I find a lot of satisfaction in correctness-by-construction. I like the idea of clean-slate abstractions and fundamental rethinking of our tools.

This all might sound impractical and overly idealistic, at least in the near-term, but I think this sort of work is leading in very exciting (and practically impactful!) directions, particularly when you take a longer-term view.

◊post-section{Fin.}
One way to sum up is this: debugging is a crucial part of writing software, but it needs to be much more effective. We need a more tasteful debugging experience. Developing simpler, more fitting abstractions at a systemic level, being able to more easily get formal proofs about our software, and surfacing more errors sooner in the development cycle (preferably at the time of construction) are important pieces of making debugging a more productive and useful endeavor.

Generally, we need far fewer lines of code and far stronger guarantees, particularly about correctness and security, from our software. We're simply not going to get that from hacking at things with currently conventional tools.

Some more food for thought on software quality and verification can be found in Hoare's ◊link["https://6826.csail.mit.edu/2020/papers/noproof.pdf"]{"How Did Software Get So Reliable Without Proof?"} and in some of Dijkstra's writing and lectures, particularly ◊link["https://www.cs.utexas.edu/~EWD/transcriptions/EWD03xx/EWD340.html"]{"The Humble Programmer."}

◊aside{The Dijkstra lecture mentioned above---"The Humble Programmer"---uses "debugging" in a different sense than I do here, which lends weight to my point that there's no clear and common definition of debugging (making it difficult to discuss properly). I interpret Dijkstra's use of debugging to indicate post-facto bug fixing, i.e. fixing bugs in existing systems which have already been deployed in production. I've instead used debugging in the general sense of fixing errors in a program. In this sense, even programs that are ostensibly correct-by-construction involve debugging during construction, i.e. figuring out why a machine-checked proof is failing.}


Alright, I've already spent far, far too long on this wall of text. Time to get back to work.

