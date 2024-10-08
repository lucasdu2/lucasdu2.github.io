#lang pollen

◊(define inner 2)
◊(define edge (* inner 2))
◊(define fontsize 16)
◊(define bgcolor "#FAF9F6")
◊(define highlightcolor "#fffcbf")
◊(define calloutcolor "#8b0000")
◊(define hovercolor "#E90017")
◊(define dividercolor "#D3D3D3")
◊(define bodywidth 32)
◊(define h1-ratio 2)
◊(define h2-ratio 1.5)
◊(define footer-ratio 0.7)
◊(define multiplier 1.3)
◊(define padding-left-align 0.3)

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

@font-face {
  font-family: "JetBrainsMono";
  src: url('fonts/JetBrainsMono-Light.ttf');
  font-weight: normal;
  font-style: normal;
}

html {
  font-size: ◊|fontsize|px;
  font-family: "Inria Sans", sans-serif;
  display: table;
  margin: auto;
}

mark {
  background-color: ◊|highlightcolor|;
}

.highlight {
  border-top: 1px solid;
  border-bottom: 1px solid;
}

.highlight pre {
  font-size: 0.8em;
  font-family: "JetBrainsMono", monospace;
}

a {
  color: ◊|calloutcolor|;
}

a:hover {
  color: ◊|hovercolor|;
}

.post-list {
  list-style-type: none;
  padding-left: 0;
}

date-marker {
  font-style: italic;
}

.link-block {
  padding: 0.4em 0;
  padding-bottom: 0.5em;
  font-family: "JetBrainsMono", monospace;
  font-size: 0.8em;
  background-color: #EEE1C6;
  text-align: center;
  border-bottom: 1px solid #535724;
}

email {
  text-decoration: underline dotted;
}

aside {
  padding: 1em;
  font-size: 0.9em;
  border: 1px solid #535724;
  border-left: 5px solid #535724;
  background: #f2f2ed;
}

.callout {
  padding: 1em;
  font-size: 0.9em;
  border: 1px solid ◊|calloutcolor|;
  border-left: 5px solid ◊|calloutcolor|;
  background: #FFDBBB;
}

header {
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  background: linear-gradient(90deg, RGBA(185, 189, 134, 1), RGBA(185, 189, 134, 0.5));
  border-top: 3px solid #535724;
  border-bottom: 1px solid #535724;
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
  color: ◊|bgcolor|;
  text-decoration: underline;
}

.portrait {
  width: 7em;
  border-radius: 50%;
  float: right;
  margin-left: 0.8em;
  border: 4px solid ◊|dividercolor|;
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
  padding-left: ◊|padding-left-align|em;
}

h2 {
  font-size: ◊|h2-ratio|em;
  padding: 0.1em;
  padding-left: ◊|padding-left-align|em;
  background: linear-gradient(90deg, rgba(195, 177, 225,1) 0%, rgba(195, 177, 225,0.2) 100%);
  border-left: 1px solid #800080;
  border-bottom: 1px solid #800080;
}

hr {
  border: none;
  border-top: 4px solid ◊|dividercolor|;
  border-bottom: 1px solid;
}

footer {
  padding-top: 0.5em;
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
      margin-bottom: 0.8em;
  }
}
