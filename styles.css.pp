#lang pollen

◊(define inner 1)
◊(define edge (* inner 2))
◊(define fontsize 18)
◊(define bgcolor "#F2F0EF")
◊(define highlightcolor "#fca199")
◊(define linkcolor "#A2574F")
◊(define hovercolor "#ED2100")
◊(define bordercolor "#222021")
◊(define accentcolor "#E2522F")
◊(define bodywidth 42)
◊(define h1-ratio 2.0)
◊(define h2-ratio 1.5)
◊(define h3-ratio 1.3)
◊(define footer-ratio 0.5)
◊(define nav-ratio 0.7)
◊(define multiplier 1.4)

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
  src: url('fonts/CrimsonPro/CrimsonPro-BoldItalic.ttf');
  font-weight: bold;
  font-style: italic;
}

@font-face {
  font-family: "CrimsonPro";
  src: url('fonts/CrimsonPro/CrimsonPro-SemiBold.ttf');
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
  font-family: "CrimsonPro", monospace;
}

.post-item {
  font-size: 1em;
  font-weight: normal;
}

.post-item a {
  text-decoration: none;
}

.post-item td {
  padding: 0.1em;
}



.post-item td:nth-of-type(2) {
  font-family: "JetBrainsMono", monospace;
  font-size: 0.8em;
  font-weight: normal;
}

.post-item td {
}

code {
  font-family: "JetBrainsMono";
  font-size: 0.9em;
}

aside {
  padding: 1em;
  font-size: 0.9em;
  border-left: 8px solid #949392;
  background: #C9C8C7;
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
  background-color: #C9C8C7;
  display: flex;
  flex-flow: row wrap;
  justify-content: space-between;
  gap: 10%;
  border: 1px solid #949392;
  border-top: 20px solid #000080;
}

header nav {
  font-size: 1em;
}

header nav a {
  color: ◊|bordercolor|;
  text-decoration: none;
  font-weight: 600;
  font-family: "JetBrainsMono", serif;
  font-size: ◊|nav-ratio|em;
  padding: 0.1em 0.5em;
  background-color: #949392;
  border: 1px solid #66615E;
  box-shadow: 5px 5px;
  margin-right: 1em;
}

header nav a:hover {
  color: #000080;
}

.portrait {
  width: 8em;
  float: left;
  margin-right: 1.5em;
  border: 1px solid ◊|bordercolor|;
}

body {
  width: ◊|bodywidth|em;
  display: table-cell;
  vertical-align: top;
  margin: ◊|edge|em;
  padding-left: ◊|inner|em;
  padding-right: ◊|inner|em;
  font-size: 1em;
  line-height: ◊|multiplier|;
}

h1 {
  font-size: ◊|h1-ratio|em;
  font-family: "CrimsonPro", sans-serif;
  font-weight: bold;
  margin: 0em;
  padding-left: 0.2em;
}

h2 {
  font-size: ◊|h2-ratio|em;
  padding: 0.1em;
  font-family: "CrimsonPro", sans-serif;
  font-weight: 600;
}

h3 {
  font-size: ◊|h3-ratio|em;
  padding: 0.1em;
  font-family: "CrimsonPro", sans-serif;
  font-weight: 600;
}

hr {
  border: none;
  border-bottom: 2px solid ◊|accentcolor|;
}

footer {
  padding-top: 1em;
  text-align: left;
  border-top: 1px dotted ◊|bordercolor|;
  font-family: "JetBrainsMono", monospace;
  font-size: ◊|footer-ratio|em;
  line-height: 1.2;
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
