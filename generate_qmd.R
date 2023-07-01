qmd_text <- function(TemplateTR = "TemplateTR",
                     TemplateEN = "TemplateEN",
                     template = "template",
                     youtube_link = "youtube_link") {

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


```{r {{template}} screenshot, eval=TRUE, include=FALSE}
if (!file.exists("./screenshots/{{template}}_screenshot.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/{{template}}/HE.html",
  file = "./screenshots/{{template}}_screenshot.png"
)
}
```


```{r, echo=FALSE, include=TRUE, eval=TRUE}
knitr::include_url(url = "https://images.patolojiatlasi.com/{{template}}/HE.html")
```

```{r, echo=FALSE, include=TRUE, eval=TRUE}
#| label: {{template}}_screenshot
#| fig-cap: "{{TemplateTR}}"
knitr::include_graphics("./screenshots/{{template}}_screenshot.png")
```

See @{{template}}_screenshot for {{TemplateTR}}.



::: {.content-hidden when-format="pdf"}
{{TemplateTR}}
:::

::: {.content-visible when-format="pdf"}
{{TemplateTR}}
:::



```{asis, echo = (language == "TR")}

**{{TemplateTR}}**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/{{template}}_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/HE.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/{{template}}/HE.html)
```


```{asis, echo = ((language=="TR") & (output_type=="html"))}
Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/{{template}}/HE.html" style="height:600px;width:100%;" data-external="1"></iframe>

```


```{comment}
asis, echo = (language == "TR")

**{{TemplateTR}}**


[![İşaretlenmiş mikroskopik görüntüleri Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/{{template}}_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/HE_annotated.html) [İşaretlenmiş mikroskopik görüntüleri Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/{{template}}/HE_annotated.html)

İşaretlenmiş mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/{{template}}/HE_annotated.html" style="height:600px;width:100%;" data-external="1"></iframe>

```



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
asis, echo = ((language=="TR") & (output_type=="html"))

((< video https://www.youtube.com/embed/{{youtube_link}} >))

```


```{comment}
asis, echo = ((language=="TR") & (output_type!="html"))

[https://www.youtube.com/watch?v={{youtube_link}}](https://www.youtube.com/watch?v={{youtube_link}})

```



```{asis, echo = (language == "EN")}

**{{TemplateEN}}**

[![Click for Full Screen WSI](./screenshots/{{template}}_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/HE.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/{{template}}/HE.html)

```



```{asis, echo = ((language == "EN") & (output_type=="html"))}

See Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/{{template}}/HE.html" style="height:600px;width:100%;" data-external="1"></iframe>

```


```{comment}
asis, echo = (language == "EN")

**{{TemplateEN}}**

[![Click for Full Screen Annotated WSI](./screenshots/{{template}}_screenshot.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/HE_annotated.html) [Click for Full Screen Annotated WSI](https://images.patolojiatlasi.com/{{template}}/HE_annotated.html)


See Annotated Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/{{template}}/HE_annotated.html" style="height:600px;width:100%;" data-external="1"></iframe>

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


```{comment}
r, eval=TRUE, echo=FALSE, include=FALSE, error=TRUE
if (!file.exists("./screenshots/{{template}}_screenshot.png")) {

url <- "https://img.youtube.com/vi/{{youtube_link}}/maxresdefault.jpg"
download.file(url, destfile = "./screenshots/{{template}}_screenshot.png", mode = "wb")
}

**{{TemplateTR}}**

[![Video İçin Tıklayın](./screenshots/{{template}}_screenshot.png){width="25%"}](https://www.youtube.com/watch?v={{youtube_link}}) [Video İçin Tıklayın](https://www.youtube.com/watch?v={{youtube_link}})

```


```{comment}
asis, echo = ((language=="EN") & (output_type=="html"))

((< video https://www.youtube.com/embed/{{youtube_link}} >))

```


```{comment}
asis, echo = ((language=="EN") & (output_type!="html"))

[https://www.youtube.com/watch?v={{youtube_link}}](https://www.youtube.com/watch?v={{youtube_link}})

```


```{comment}
=html
<iframe src="https://images.patolojiatlasi.com/{{template}}/HE.html" style="height:600px;width:100%;" data-external="1"></iframe>
```

'

  data <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    youtube_link = youtube_link
  )

  qmdtext <- whisker::whisker.render(template_string, data)

  qmdtext <- gsub(pattern = "((<", replacement = "{{<", x = qmdtext, fixed = TRUE)

  qmdtext <- gsub(pattern = ">))", replacement = ">}}", x = qmdtext, fixed = TRUE)

  return(qmdtext)
}

text_to_write <- qmd_text()
writeLines(text = text_to_write, con = "./newqmd.qmd", sep = "\n")
