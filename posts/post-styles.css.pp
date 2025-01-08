#lang pollen

◊(define bordercolor "#222021")
◊(define titleratio 2.0)
◊(define sectionratio 1.5)

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
  border-bottom: 2px solid ◊|bordercolor|;
  background: none;
}

h3 {
  text-align: center;
  text-decoration: underline;
}

.post-date {
  margin: 0;
  font-style: italic;
}
