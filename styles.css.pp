#lang pollen

◊(define inner 2)
◊(define edge (* inner 2))
◊(define fontsize 16)
◊(define bgcolor "#FEFBEA")
◊(define highlightcolor "#fcf1b6")
◊(define calloutcolor "#8b0000")
◊(define bodywidth 40)
◊(define h1-ratio 2)
◊(define h2-ratio 1.5)
◊(define footer-ratio 0.7)
◊(define multiplier 1.3)

@font-face {
  font-family: "Inria Sans";
  src: url('fonts/inria-sans/InriaSans-Regular.ttf');
  font-weight: normal;
  font-style: normal;
}

@font-face {
  font-family: "Inria Sans";
  src: url('fonts/inria-sans/InriaSans-Italic.ttf');
  font-weight: normal;
  font-style: italic;
}

@font-face {
  font-family: "Inria Sans";
  src: url('fonts/inria-sans/InriaSans-Bold.ttf');
  font-weight: bold;
  font-style: normal;
}

html {
  font-size: ◊|fontsize|px;
  font-family: "Inria Sans", sans-serif;
  display: table;
  margin: auto;
  background: ◊|bgcolor|;
}

header {
  border-bottom: 2px solid #D3D3D3;
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  align-items: center;
  gap: 10%;
}

header p {
  margin: 0;
  padding: 0;
  font-size: 1.2em;
  font-weight: bold;
}

header p a {
  text-decoration: none;
  padding: 0em 0.2em;
}

header p a:hover {
  text-decoration: none;
  background-color: ◊|highlightcolor|;
}

a:link, a:visited {
  color: ◊|calloutcolor|;
}

.portrait {
  width: 15em;
  border-radius: 50%;
  float: right;
  margin: 0.7em;
  border: 3px solid #D3D3D3;
}

body {
  width: ◊|bodywidth|em;
  display: table-cell;
  vertical-align: middle;
  margin: ◊|edge|em;
  padding: ◊|inner|em;
  font-size: 1em;
  line-height: ◊|multiplier|;
}

h1 {
  font-size: ◊|h1-ratio|em;
  margin: 0em;
}

h2 {
  font-size: ◊|h2-ratio|em;
  padding-left: 0.2em;
  background: linear-gradient(90deg, rgba(195, 177, 225,1) 0%, rgba(195, 177, 225,0.2) 100%);
  border-left: 1px solid #800080;
  border-bottom: 1px solid #800080;
}

footer {
  border-top: 2px solid #D3D3D3;
  font-size: ◊|footer-ratio|em;
}

/* --- narrow layout adjustments --- */
@media screen and (max-width: 450px) {
  .portrait {
      float: none;
      display: block;
      margin-left: auto;
      margin-right: auto;
  }
}
