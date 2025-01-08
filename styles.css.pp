#lang pollen

◊(define inner 2)
◊(define edge (* inner 2))
◊(define fontsize 18)
◊(define bgcolor "#FCD299")
◊(define highlightcolor "#fca199")
◊(define linkcolor "#8b0000")
◊(define hovercolor "#E90017")
◊(define bordercolor "#222021")
◊(define accentcolor "#E2522F")
◊(define bodywidth 42)
◊(define h1-ratio 2.5)
◊(define h2-ratio 1.5)
◊(define h3-ratio 1.3)
◊(define footer-ratio 0.5)
◊(define nav-ratio 0.7)
◊(define multiplier 1.3)

 ::-moz-selection {
  background: #99c3fc;
}

::selection {
  background: #99c3fc;
}

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
  font-weight: 900;
  font-style: normal;
}

@font-face {
  font-family: "Handjet";
  src: url('fonts/Handjet/Handjet-Bold.ttf');
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

@font-face {
  font-family: "JetBrainsMono";
  src: url('fonts/JetBrainsMono-Bold.ttf');
  font-weight: bold;
  font-style: normal;
}

@font-face {
  font-family: "JetBrainsMono";
  src: url('fonts/JetBrainsMono-Medium.ttf');
  font-weight: 600;
  font-style: normal;
}


html {
  font-size: ◊|fontsize|px;
  font-family: "CrimsonPro", serif;
  display: table;
  margin: auto;
  background: ◊|bgcolor|;
  height: 100%;
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
  margin-top: 1em;
  border-collapse: collapse;
  width: 100%;
  font-family: "JetBrainsMono", monospace;
}

.post-item {
  font-size: 0.8em;
  font-weight: 600;
}

.post-item a {
  text-decoration: none;
}

.post-item td {
  padding: 0.1em;
}

.post-item td:nth-of-type(2) {
  text-align: right;
}

.post-item td {
  border-bottom: 1px dotted ◊|bordercolor|;
}

code {
  font-family: "JetBrainsMono";
  font-size: 0.9em;
}

aside {
  padding: 1em;
  font-size: 0.9em;
  border-left: 8px solid #fab14f;
  background: #FCC981;
}

.callout {
  padding: 1em;
  text-align: center;
  font-weight: 600;
  border-top: 8px solid #fb7367;
  background: ◊|highlightcolor|;
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
  font-family: "JetBrainsMono", monospace;
  font-size: ◊|nav-ratio|em;
  padding: 0.1em 0.5em;
  background-color: ◊|bordercolor|;
}

header nav a:hover {
  color: ◊|bgcolor|;
  text-decoration: underline;
}

.portrait {
  width: 6.5em;
  float: left;
  margin-right: 1.5em;
  border: 1px solid ◊|bordercolor|;
}

body {
  width: ◊|bodywidth|em;
  display: table-cell;
  vertical-align: top;
  margin: ◊|edge|em;
  padding: ◊|inner|em;
  font-size: 1em;
  line-height: ◊|multiplier|;
}

h1 {
  font-size: ◊|h1-ratio|em;
  font-family: "Handjet", "CrimsonPro", serif;
  font-weight: 900;
  margin: 0em;
}

h2 {
  font-size: ◊|h2-ratio|em;
  padding: 0.1em;
  font-family: "Handjet", "CrimsonPro", serif;
  font-weight: bold;
}

h3 {
  font-size: ◊|h3-ratio|em;
  padding: 0.1em;
  font-family: "Handjet", "CrimsonPro", serif;
  font-weight: bold;
}

hr {
  border: none;
  border-bottom: 2px solid ◊|accentcolor|;
}

footer {
  padding-top: 1em;
  text-align: center;
  border-top: 1px dotted ◊|bordercolor|;
  font-family: "JetBrainsMono", monospace;
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
