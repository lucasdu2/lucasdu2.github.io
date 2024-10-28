#lang pollen

◊(define bordercolor "#222021")
◊(define accentcolor "#E2522F")
◊(define titleratio 1.7)
◊(define sectionratio 1.3)

header {
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  background: none;
  border-top: none;
  border-bottom: 3px solid ◊|bordercolor|;
  gap: 10%;
}

footer {
  border-top: none;
  text-align: center;
  font-size: 1em;
}

h1 {
  font-size: ◊|titleratio|em;
  padding: 0.1em 0;
}

h2 {
  font-size: ◊|sectionratio|em;
  padding-left: 0;
  padding-top: 0.1em;
  padding-bottom: 0.1em;
  border-left: none;
  border-bottom: 3px solid ◊|bordercolor|;
  background: none;
}

.post-date {
  margin: 0;
  font-style: italic;
}
