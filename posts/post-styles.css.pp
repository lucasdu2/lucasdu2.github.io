#lang pollen

◊(define dividercolor "#D3D3D3")
◊(define titleratio 1.7)
◊(define sectionratio 1.3)

header {
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  background: none;
  border-top: none;
  border-bottom: 3px solid #535724;
  gap: 10%;
}

footer {
  border-top: 1px solid;
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
  border-bottom: 3px solid ◊|dividercolor|;
  background: none;
}

.post-date {
  margin: 0;
  color: #858a7e;
}
