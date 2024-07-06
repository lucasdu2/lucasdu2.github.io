#lang pollen

◊(define inner 2)
◊(define edge (* inner 2))
◊(define fontsize 16)
◊(define bgcolor "#FAF9F6")
◊(define highlightcolor "#FEFBEA")
◊(define calloutcolor "#8b0000")
◊(define dividercolor "#D3D3D3")
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
}

header {
  border-bottom: 2px solid ◊|dividercolor|;
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  background: linear-gradient(90deg, RGBA(185, 189, 134, 1), RGBA(185, 189, 134, 0.5));
  border-top: 2px solid #535724;
  border-bottom: 2px solid #535724;
  gap: 10%;
}

header nav {
  display: flex;
  align-items: start;
  font-size: 1em;
  gap: 0.5em;
  margin-right: 0.5em;
}

header nav a {
  color: ◊|bgcolor|;
  text-decoration: none;
  padding: 0.2em 0.4em;
  background-color: #535724;
}

header nav a:hover {
  text-decoration: underline;
}

a:link, a:visited {
}

.portrait {
  width: 15em;
  border-radius: 30%;
  float: right;
  margin: 1em;
  border: 3px solid ◊|dividercolor|;
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
  padding-left: 0.2em;
}

h2 {
  font-size: ◊|h2-ratio|em;
  padding-left: 0.2em;
  padding-top: 0.1em;
  background: linear-gradient(90deg, rgba(195, 177, 225,1) 0%, rgba(195, 177, 225,0.2) 100%);
  border-left: 1px solid #800080;
  border-bottom: 1px solid #800080;
}

footer {
  border-top: 2px solid ◊|dividercolor|;
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
