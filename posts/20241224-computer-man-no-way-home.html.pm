#lang pollen

◊post-title{Computer-Man: No Way Home}
◊post-date{Tuesday December 24, 2024}

It's the end of a lot of things in my life recently --- the end of Recurse Center, the end of my year in New York City, the end of my time hanging around with the folks at NYU ACSys, and the end of my 25th year (and the end of parental health insurance!). It's the beginning of a lot of exciting things too.

It's hard to make sense of it all. Maybe it doesn't matter if I make sense of it. Life moves on inexorably and there's no way back and that's all part of the fun. I wrote (a long time ago now, it feels) in a college application essay about the myth of square one --- it's impossible to erase what's been done, the tabula rasa no longer exists, so stop worrying about perfection and just keep on painting... I've since lost the essay to the digital depths (where is my external hard drive?), but I still think about it now and then. I still resonate with its sentiments.

◊post-section{RC: Return}
In true RC form, here's the traditional "return statement," in which I reflect on my time at Recurse, think about what comes next, and add to the corpus of Recurse-related outreach/marketing floating around on the internet!

◊mark{In short, I had a really great time.} I think it's a rare and beautiful experience for a certain person at a certain stage in their life. If the values of Recurse resonate with you and if you are at a point where you really want to have the freedom to work on things you personally care about and grow in the ways that ◊em{you} want to grow (also probably most importantly: ◊em{if you can afford to take a 6- or 12-week break from money-making work...}), ◊mark{Recurse is well worth applying to and, hopefully, attending.}

◊post-subsection{What I did}
◊items{
  ◊item{◊strong{Worked through the first couple chapters and accompanying projects of Program=Proof by Samuel Mimram.} I got to do this with a couple other people at Recurse, which was tons of fun. It's weird being in a place where people are interested in the same things I'm interested in, no matter how niche. It's even weirder to be in a place where a self-directed study group actually holds together for 12 weeks, without the outside pressure of deadlines or grades.}
  ◊item{◊strong{Learned enough OCaml to get by}, mostly for the Program=Proof exercises.}
  ◊item{◊strong{Read various papers on program logics (particularly separation logic, and even more particularly Iris) and automated deduction techniques (i.e. SMT solvers).} This was for some research work that I was trying to do concurrently at NYU, but it tied in nicely with my general goal at Recurse of, well, learning more about programming languages and formal verification for potential research work.}
  ◊item{◊strong{Took a quick detour into probabilistic data structures} and wrote up a Racket implementation of a Bloom filter. I gave a 5-minute presentation on this too! There's a lot more here that I find fascinating --- probabilistic programs are a deep theoretical topic and also the subject of some recent work in verification! --- but we'll have to see if I'll have time to return to it.}
  ◊item{◊strong{Wrote a very naive DPLL SAT solver in Racket and used it to implement an automatic Sudoku solver.} This was definitely the most fulfilling programming project of my batch, probably because I was more familiar with Racket than with OCaml and I was able to make substantive progress relatively quickly. There's a fancier OCaml solver that I intend to finish, which incorporates some more advanced and interesting optimizations. But you know what they say about good intentions...}
}

◊post-subsection{What I wish I did}
A lot of the time, it really felt as if I wasn't doing enough --- there are just so many things you ◊em{could} be doing and there just simply isn't enough time to do it all! I guess this is also a broader problem in life that I just need to get better at grappling with and accepting. 

There were a number of more programming-heavy things I came into Recurse thinking I might do --- writing a simple web application, implementing a text editor, writing a compiler (an ◊em{educational} compiler, of course!), or finishing and testing my Viewstamped Replication implementation (which I've let sit, untouched, for months) --- and initially I thought I would be able to squeeze some of that in. But the more theory-oriented stuff that related to my research interests ended up dominating my time.

◊aside{I also wasn't able to do a lot of the more theory-oriented work that I had in mind --- i.e. learning more about choreographic programming and session types, doing something with Idris and dependent types, or learning the basics of a proof assistant. It was just too ambitious. Recurse can feel like your ◊em{one chance} to do all the stuff you've wanted to do, but treating it in that way isn't the healthiest, I think. It's a chance to do ◊em{some of those things} and to hang out with fun people. You'll get more chances to do the other things --- life is long.}

I could have avoided a good deal of mental angst by simply being a bit more realistic about my time and my abilities. There definitely is a discipline and an art to saying "no," even just to yourself. I think that spending the first two weeks paring down priorities and finding people with compatible goals, then really committing to one or two things and grinding at them, would have been much more fulfilling.

As it was, I ended up floating around and dabbling in various random things, which sapped a lot of my focus and forward momentum. There's value in that too, depending on what you're looking to get out of the experience. But because I came in with my interests relatively set, I think I would have been better served just diving in more quickly and more deeply into those interests.

◊aside{As an aside, I generally feel like Recurse is a far better place for people who are working on implementation-heavy projects, with high-quality online resources floating around, than for people who are interested in digging into more theory-oriented work. I guess that makes sense, given its billing as a retreat for ◊em{programmers} (not computer scientists, or theorists). Being around lots of people who are writing code definitely provides motivation and momentum to write lots of your own code, and it opens up more opportunities for ◊em{pairing}, which is something Recurse holds in high esteem.}

Besides focusing more on and committing earlier to one or two things, here are a couple things I wish I did more:
◊items{
  ◊item{Had lunch at the lunch table more often --- the social aspect of Recurse was one of the highlights of my experience and I wish I spent more time interacting with more people. The lunch table offers a really good place to do that!}
  ◊item{Done a project that had a bigger implementation component --- I do think that getting to write lots of code is something that Recurse is ◊em{very good for}, just by the way it's structured and the activities (i.e. pairing) that it pushes. Reading books and doing more theory-oriented things is certainly possible and fulfilling at Recurse, particularly if you get a healthy group going, but not in the same way (in my view).}
}

◊aside{As another aside, I do think there's also a ton of value in coming into RC with some loose interests and then taking a good deal of time to just explore all the random and cool things that other people are working on. There really is ◊em{so much} going on at Recurse, all the time. Hopping into someone else's passion project, if only for a bit, can be at once fulfilling and eye-opening. I just don't think that was generally the right approach for me.}

◊post-subsection{Some general reflections}
As a final note, I think your Recurse experience can vary quite a bit based on the makeup of your batch. This is particularly true if you're into some more niche things. But the cool thing is that you will almost always find ◊em{someone} in your batch with similar interests. Lots of alums stick around as well!

And regardless, I think the culture that Recurse has set up, the space that the program has created for you to simply explore and work on the things that ◊em{you want to do} is well, well worth it, even if you don't find anyone who has interests that exactly match your own. Simply hanging out with people who find joy (and not just profit) in programming, either in-person, over Zoom, or on Zulip, is pretty fantastic. 

◊post-section{No Way Home◊fn[1]}
◊fndef[1]{lol...to be fair, it's a good movie (maybe a hot take?). And it sort of makes sense in this context.}
There is a strange sense that this is a particular marker for me in my life --- a time when lots of things are at once ending and beginning. I quit my job, the retreat that RC provided is over, I'm starting an MS program in a new city, in a new state, and I'm really committing to something that I'm deeply interested in, excited about, and believe is important.

I think the commitment part is the scariest thing about it. If all goes according to plan, this is how I'm going to spend the last half of my 20s (and the start of my 30s!). That's time I'll never get back. There are sacrifices to be made. There will be things that I just won't be able to do (or do as easily as if I had just continued on in a career as a corporate software developer). But that's the way things go, I guess. Life has to be lived.

I'm really going to miss being in New York City and hanging out with all my college friends. It seems like there are always millions of tiny things you don't quite realize you took for granted when you live and exist somewhere. It's only when you leave a place that you really feel their unexpected absence.

But I'm very excited about where I am now and where I want to go. And there really is nowhere to go but forward.
