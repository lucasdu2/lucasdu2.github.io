#lang pollen

◊(define bordercolor "#222021")
◊(define titleratio 2.0)
◊(define sectionratio 1.5)
◊(define subsectionratio 1.2)

header {
  display: flex;
  flex-flow: row wrap;
  border: none;
  background: none;
  border-top: 12px solid #000080;
  padding-top: 0.4em;
  justify-content: center;
  gap: 10%;
  background-color: #e6e5e5;
}

footer {
  border-top: none;
  text-align: center;
  font-size: 1em;
  margin-bottom: 2em;
}

h1 {
  background-color: #e6e5e5;
  padding-top: 0.3em;
  font-size: ◊|titleratio|em;
  text-align: center;
}

h2 {
  font-size: ◊|sectionratio|em;
  padding-left: 0;
  padding-top: 0.1em;
  padding-bottom: 0.1em;
  border-bottom: 1px solid ◊|bordercolor|;
  background: none;
  text-align: center;
}

h3 {
  font-size: ◊|subsectionratio|em;
  border-bottom: 1px dotted ◊|bordercolor|;
}

.post-date {
  margin: 0;
  font-family: "JetBrainsMono", monospace;
  font-size: 0.8em;
  text-align: center;
  padding-bottom: 1em;
  border-bottom: 1px solid #949392;
  background-color: #e6e5e5;
}

section.footnotes {
  border-top: 1px dotted ◊|bordercolor|;
  font-size: 0.8em;
  padding-right: 2em;
}
