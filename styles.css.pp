#lang pollen

◊(define inner 2)
◊(define edge (* inner 2))
◊(define fontsize 18)
◊(define bgcolor "#FCD299")
◊(define highlightcolor "#A7FCEF")
◊(define linkcolor "#8b0000")
◊(define hovercolor "#E90017")
◊(define bordercolor "#222021")
◊(define accentcolor "#E2522F")
◊(define bodywidth 42)
◊(define h1-ratio 2)
◊(define h2-ratio 1.5)
◊(define footer-ratio 0.7)
◊(define multiplier 1.3)

@font-face {
  font-family: "CrimsonPro";
  src: url('fonts/CrimsonPro/CrimsonPro-Regular.ttf');
  font-weight: normal;
  font-style: normal;
}

@font-face {
  font-family: "CrimsonPro";
  src: url('fonts/CrimsonPro/CrimsonPro-Italic.ttf');
  font-weight: normal;
  font-style: italic;
}

@font-face {
  font-family: "CrimsonPro";
  src: url('fonts/CrimsonPro/CrimsonPro-Bold.ttf');
  font-weight: bold;
  font-style: normal;
}

@font-face {
  font-family: "CrimsonPro";
  src: url('fonts/CrimsonPro/CrimsonPro-SemiBold.ttf');
  font-weight: 600;
  font-style: normal;
}

@font-face {
  font-family: "CrimsonPro";
  src: url('fonts/CrimsonPro/CrimsonPro-BlackItalic.ttf');
  font-weight: bold;
  font-style: italic;
}

@font-face {
  font-family: "Handjet";
  src: url('fonts/Handjet/Handjet-Black.ttf');
  font-weight: bold;
  font-style: normal;
}

@font-face {
  font-family: "Handjet";
  src: url('fonts/Handjet/Handjet-SemiBold.ttf');
  font-weight: 600;
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
  font-family: "CrimsonPro", serif;
  display: table;
  margin: auto;
  background: ◊|bgcolor|;
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
  color: ◊|linkcolor|;
}

a:hover {
  color: ◊|hovercolor|;
}

.post-table {
  width: 100%;
}

.post-item {
  font-size: 0.8em;
  font-family: "JetBrains Mono", monospace;
}

aside {
  padding: 1em;
  font-size: 0.9em;
  border: 1px solid #5A61B0;
  border-left: 5px solid #5A61B0;
  background: #FCC981;
}

.callout {
  padding: 1em;
  font-size: 0.9em;
  border: 1px solid #E2522F;
  border-left: 5px solid #E2522F;
  background: #FEE68E;
}

section.footnotes {
  font-size: 0.8em;
  padding-right: 2em;
}

header {
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  gap: 10%;
  border-bottom: 4px solid ◊|bordercolor|;
}

header nav {
  display: flex;
  align-items: end;
  font-size: 1em;
  gap: 0.5em;
  margin-right: 0.5em;
}

header nav a {
  color: ◊|bgcolor|;
  text-decoration: none;
  font-weight: 600;
  padding: 0.1em 0.6em;
  background-color: ◊|bordercolor|;
}

header nav a:hover {
  color: ◊|bgcolor|;
  text-decoration: underline;
}

.portrait {
  width: 7em;
  float: left;
  margin-right: 1.5em;
  border: 1px solid ◊|bordercolor|;
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
  font-family: "Handjet", "CrimsonPro", serif;
  margin: 0em;
}

h2 {
  font-size: ◊|h2-ratio|em;
  padding: 0.1em;
  font-family: "Handjet", "CrimsonPro", serif;
  font-weight: 600;
}

hr {
  border: none;
  border-bottom: 2px solid ◊|accentcolor|;
}

footer {
  padding-top: 0.5em;
  border-top: 2px solid ◊|bordercolor|;
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
