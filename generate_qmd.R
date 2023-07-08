# qmd_text_info ----
qmd_text_info <- function(TemplateTR = "TemplateTR",
                       TemplateEN = "TemplateEN",
                       template = "template") {

template_string <- '# {{template}}





**{{template}} for pathology atlas repositories**


```
see [make-html-WSI](https://github.com/pathologyatlas/make-html-WSI) for more information and [TODO](https://github.com/pathologyatlas/TODO) to add cases
```

```
update html file heading:

<title>{{TemplateEN}} {{TemplateTR}}</title>

<meta name="keywords" content="{{TemplateEN}}, {{TemplateTR}}, patoloji, atlas, pathology, whole slide image">

<meta name="description" content="{{TemplateEN}} {{TemplateTR}}">

```



```zsh

vips dzsave HE.svs HE

```



```
update html file to match .dzi file

```





> consider using git_push.sh script to upload files to github, since the number of generated files is huge

> after upload complete, do not forget to activate github pages for the new repository









'


  data <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template
  )

  qmdtextinfo <- whisker::whisker.render(template_string, data)

  qmdtextinfo <- gsub(pattern = "((<", replacement = "{{<", x = qmdtextinfo, fixed = TRUE)

  qmdtextinfo <- gsub(pattern = ">))", replacement = ">}}", x = qmdtextinfo, fixed = TRUE)

  return(qmdtextinfo)


  }



# qmd_text_base ----

qmd_text_base <- function(TemplateTR = "TemplateTR",
                          TemplateEN = "TemplateEN",
                          template = "template",
                          stain = c("HE1", "HE2")) {

template_string_1 <- '


```{r language {{template}}, echo=FALSE, include=TRUE}
source("./R/language.R")
output_type <- knitr::opts_knit$get("rmarkdown.pandoc.to")
```


```{asis, echo = (language == "TR")}
## {{TemplateTR}} {#sec-{{template}} }
```


```{asis, echo = (language == "EN")}
## {{TemplateEN}} {#sec-{{template}} }
```

'

template_string_2 <- '

```{r {{template}} screenshot {{stain}}, eval=TRUE, include=FALSE}
if (!file.exists("./screenshots/{{template}}-{{stain}}_screenshot.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/{{template}}/{{stain}}.html",
  file = "./screenshots/{{template}}-{{stain}}_screenshot.png"
)
}
```



```{asis, echo = (language == "TR")}

**{{TemplateTR}}**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/{{template}}-{{stain}}_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)
```


```{asis, echo = ((language=="TR") & (output_type=="html"))}
Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>

```


```{asis, echo = (language == "EN")}

**{{TemplateEN}}**

[![Click for Full Screen WSI](./screenshots/{{template}}-{{stain}}_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)

```



```{asis, echo = ((language == "EN") & (output_type=="html"))}

See Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>

```


'

data_1 <- list(
  TemplateTR = TemplateTR,
  TemplateEN = TemplateEN,
  template = template)

qmdtextbase <- whisker::whisker.render(template_string_1, data_1)


for (s in stain) {
  data_2 <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    stain = s
  )

  temp <- whisker::whisker.render(template_string_2, data_2)


  qmdtextbase <- paste(qmdtextbase, temp, sep = "\n\n")

}

qmdtextbase <- gsub(pattern = "((<", replacement = "{{<", x = qmdtextbase, fixed = TRUE)
qmdtextbase <- gsub(pattern = ">))", replacement = ">}}", x = qmdtextbase, fixed = TRUE)

return(qmdtextbase)

}

# qmd_text_question_answer ----

qmd_text_question_answer <- function(TemplateTR = "TemplateTR",
                          TemplateEN = "TemplateEN",
                          template = "template",
                          youtube_link = "youtube_link") {

  template_string <- '


```{comment}
asis, echo = (language == "TR")



<button id="tani-case-{{template}}-btn">Tanıyı Göster</button>
<div id="answer-{{template}}" style="display: none;">{{TemplateTR}}</div>

<script>
  const showAnswer-{{template}}Btn = document.getElementById("tani-case-{{template}}-btn");
  const answer-{{template}} = document.getElementById("answer-{{template}}");

  showAnswer-{{template}}Btn.addEventListener("click", () => {
    if (answer-{{template}}.style.display === "none") {
      answer-{{template}}.style.display = "block";
      showAnswer-{{template}}Btn.textContent = "Tanıyı Gizle";
    } else {
      answer-{{template}}.style.display = "none";
      showAnswer-{{template}}Btn.textContent = "Tanıyı Göster";
    }
  });
</script>

```


```{comment}
asis, echo = (language == "EN")

<button id="dx-case-{{template}}-btn">Show the Diagnosis</button>
<div id="answer-{{template}}" style="display: none;">{{TemplateEN}}</div>

<script>
  const showAnswer-{{template}}Btn = document.getElementById("dx-case-{{template}}-btn");
  const answer-{{template}} = document.getElementById("answer-{{template}}");

  showAnswer-{{template}}Btn.addEventListener("click", () => {
    if (answer-{{template}}.style.display === "none") {
      answer-{{template}}.style.display = "block";
      showAnswer-{{template}}Btn.textContent = "Hide the Diagnosis";
    } else {
      answer-{{template}}.style.display = "none";
      showAnswer-{{template}}Btn.textContent = "Show the Diagnosis";
    }
  });
</script>

```


'

  data <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    youtube_link = youtube_link
  )

  qmdtextqa <- whisker::whisker.render(template_string, data)

  qmdtextqa <- gsub(pattern = "((<", replacement = "{{<", x = qmdtextqa, fixed = TRUE)

  qmdtextqa <- gsub(pattern = ">))", replacement = ">}}", x = qmdtextqa, fixed = TRUE)

  return(qmdtextqa)


}


# qmd_text_video ----

qmd_text_video <- function(TemplateTR = "TemplateTR",
                          TemplateEN = "TemplateEN",
                          template = "template",
                          youtube_link = "youtube_link") {

  template_string <- '


```{comment}
asis, echo = ((language=="TR") & (output_type=="html"))

((< video https://www.youtube.com/embed/{{youtube_link}} >))

```


```{comment}
asis, echo = ((language=="TR") & (output_type!="html"))

[https://www.youtube.com/watch?v={{youtube_link}}](https://www.youtube.com/watch?v={{youtube_link}})

```

```{comment}
r, eval=TRUE, echo=FALSE, include=FALSE, error=TRUE
if (!file.exists("./screenshots/{{template}}-{{stain}}_screenshot.png")) {

url <- "https://img.youtube.com/vi/{{youtube_link}}/maxresdefault.jpg"
download.file(url, destfile = "./screenshots/{{template}}-{{stain}}_screenshot.png", mode = "wb")
}

**{{TemplateTR}}**

[![Video İçin Tıklayın](./screenshots/{{template}}-{{stain}}_screenshot.png){width="25%"}](https://www.youtube.com/watch?v={{youtube_link}}) [Video İçin Tıklayın](https://www.youtube.com/watch?v={{youtube_link}})

```


```{comment}
asis, echo = ((language=="EN") & (output_type=="html"))

((< video https://www.youtube.com/embed/{{youtube_link}} >))

```


```{comment}
asis, echo = ((language=="EN") & (output_type!="html"))

[https://www.youtube.com/watch?v={{youtube_link}}](https://www.youtube.com/watch?v={{youtube_link}})

```


'

  data <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    youtube_link = youtube_link
  )

  qmdtextvideo <- whisker::whisker.render(template_string, data)

  qmdtextvideo <- gsub(pattern = "((<", replacement = "{{<", x = qmdtextvideo, fixed = TRUE)

  qmdtextvideo <- gsub(pattern = ">))", replacement = ">}}", x = qmdtextvideo, fixed = TRUE)

  return(qmdtextvideo)

}


# qmd_text_comment ----

qmd_text_comment <- function(TemplateTR = "TemplateTR",
                     TemplateEN = "TemplateEN",
                     template = "template") {

template_string <- '



```{r, echo=FALSE, include=FALSE, eval=FALSE}
knitr::include_url(url = "https://images.patolojiatlasi.com/{{template}}/{{stain}}.html")
```

```{r, echo=FALSE, include=FALSE, eval=FALSE}
#| label: {{template}}_screenshot
#| fig-cap: "{{TemplateTR}}"
knitr::include_graphics("./screenshots/{{template}}-{{stain}}_screenshot.png")
```


::: {.content-hidden when-format="pdf"}
{{TemplateTR}}
:::

::: {.content-visible when-format="pdf"}
{{TemplateTR}}
:::





```{comment}
asis, echo = (language == "TR")

**{{TemplateTR}}**


[![İşaretlenmiş mikroskopik görüntüleri Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/{{template}}-{{stain}}_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/HE_annotated.html) [İşaretlenmiş mikroskopik görüntüleri Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/{{template}}/HE_annotated.html)

İşaretlenmiş mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/{{template}}/HE_annotated.html" style="height:600px;width:100%;" data-external="1"></iframe>

```



```{comment}
asis, echo = (language == "EN")

**{{TemplateEN}}**

[![Click for Full Screen Annotated WSI](./screenshots/{{template}}-{{stain}}_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/HE_annotated.html) [Click for Full Screen Annotated WSI](https://images.patolojiatlasi.com/{{template}}/HE_annotated.html)


See Annotated Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/{{template}}/HE_annotated.html" style="height:600px;width:100%;" data-external="1"></iframe>

```


```{comment}
=html
<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>
```

'

  data <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template
  )

  qmdtext <- whisker::whisker.render(template_string, data)

  qmdtext <- gsub(pattern = "((<", replacement = "{{<", x = qmdtext, fixed = TRUE)

  qmdtext <- gsub(pattern = ">))", replacement = ">}}", x = qmdtext, fixed = TRUE)

  return(qmdtext)
}



info_text <- qmd_text_info()
base_text <- qmd_text_base()
qa_text <- qmd_text_question_answer()
video_text <- qmd_text_video()
comment_text <- qmd_text_comment()

text_to_write <- paste0(info_text, base_text, qa_text, video_text, comment_text, collapse = "\r\n\n")

writeLines(text = text_to_write, con = "./newqmd.qmd", sep = "\n")
