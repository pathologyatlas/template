# QMD TEXT ----

qmd_text <- function(
    base_template = FALSE,
    TemplateTR = "TemplateTR",
    TemplateEN = "TemplateEN",
    template = "template",
    stain = c("HE1", "HE2"),
    diagnosis = FALSE,
    use_youtube = FALSE,
    youtube_link = "youtube_link"
    ) {

# base_string ----

base_string <- '

# {{template}}


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

# head_string ----

head_string <- '


((< include ./_subchapters/_{{template}}.qmd >))



```{comment}
---
description: |
    {{TemplateTR}}, {{TemplateEN}}, patoloji, atlas, pathology, whole slide image
date: last-modified
categories: [{{TemplateTR}}, {{TemplateEN}}]
page-layout: full
bibliography: references.bib
---
```



```{r language {{template}}, echo=FALSE, include=TRUE}
source("./R/language.R")
output_type <- knitr::opts_knit$get("rmarkdown.pandoc.to")
```


```{asis {{TemplateTR}} TR , echo = (language == "TR")}
## {{template}} - {{TemplateTR}} {#sec-{{template}} }
```


```{asis {{TemplateEN}} EN , echo = (language == "EN")}
## {{template}} - {{TemplateEN}} {#sec-{{template}} }
```

'


# screenshot_string ----

screenshot_string <- '


```{r {{template}} screenshot {{stain}}, eval=TRUE, include=FALSE}
if (!file.exists("./screenshots/thumbnail_{{template}}-{{stain}}.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/{{template}}/{{stain}}.html",
  file = "./screenshots/thumbnail_{{template}}-{{stain}}.png"
)
}
```



```{r {{template}} qrcode {{stain}}, eval=TRUE, echo=FALSE, include=FALSE, error=TRUE}
if (!file.exists("./qrcodes/{{template}}-{{stain}}_qrcode.svg")) {

  qrcode_svg <- qrcode::qr_code("https://images.patolojiatlasi.com/{{template}}/{{stain}}.html")

  qrcode::generate_svg(qrcode = qrcode_svg,
                       filename = "./qrcodes/{{template}}-{{stain}}_qrcode.svg",
                       show = FALSE)
}
```







'

# tab1 ----

tab1 <- '

::::: panel-tabset


### WSI - Link


'

# wsi_link_string ----

wsi_link_string <- '



:::: {.content-hidden when-format="pdf"}


```{asis, echo = (language == "TR")}

**{{TemplateTR}}**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/thumbnail_{{template}}-{{stain}}.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)

```

::::


:::: {.content-visible when-format="pdf"}

```{asis, echo = (language == "TR")}

**{{TemplateTR}}**

![](./qrcodes/{{template}}-{{stain}}_qrcode.svg){width="15%"} [![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/thumbnail_{{template}}-{{stain}}.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)

```



::::




:::: {.content-hidden when-format="pdf"}


```{asis, echo = (language == "EN")}

**{{TemplateEN}}**

[![Click for Full Screen WSI](./screenshots/thumbnail_{{template}}-{{stain}}.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)

```

::::


:::: {.content-visible when-format="pdf"}

```{asis, echo = (language == "EN")}

**{{TemplateEN}}**

![](./qrcodes/{{template}}-{{stain}}_qrcode.svg){width="15%"} [![Click for Full Screen WSI](./screenshots/thumbnail_{{template}}-{{stain}}.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)

```


::::



'

# tab2 ----

tab2 <- '

### WSI


'


# wsi_string ----

wsi_string <- '



```{asis, echo = ((language=="TR") & (output_type=="html"))}
Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>

```





```{asis, echo = ((language == "EN") & (output_type=="html"))}

See Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>

```

'



# diagnosis_string ----


  diagnosis_string <-
'

### Diagnosis


```{asis, echo = (language == "TR")}


::: {.callout-tip collapse="true" appearance="default" icon="true"}
### Tanı için tıklayın

{{TemplateTR}}

:::


```


```{asis, echo = (language == "EN")}


::: {.callout-tip collapse="true" appearance="default" icon="true"}
### Click for Diagnosis

{{TemplateEN}}

:::

```




'

# youtube_string ----


    youtube_string <-

'

### Video



```{asis, echo = (language == "TR")}

[Video İçin Tıklayın](https://www.youtube.com/watch?v={{youtube_link}})

```


```{asis, echo = (language == "EN")}

[Click for Video](https://www.youtube.com/watch?v={{youtube_link}})

```



::: {.content-visible when-format="html"}

((< video https://www.youtube.com/embed/{{youtube_link}} >))

:::

'


# end_string ----

end_string <-
  '


:::::














'

# qmd_text ----

qmd_text <- ''


# base render ----

if (base_template) {

  data_base <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template)

  base_string <- whisker::whisker.render(base_string, data_base)


    qmd_text <- paste(qmd_text, base_string, sep = "\n\n")


  }



# head render ----


data_head <- list(
  TemplateTR = TemplateTR,
  TemplateEN = TemplateEN,
  template = template)

head_text <- whisker::whisker.render(head_string, data_head)


qmd_text <- paste(qmd_text, head_text, sep = "\n\n")



# screenshot render ----

for (s in stain) {
  data_screenshot <- list(
    template = template,
    stain = s
  )

  screenshot_text <- whisker::whisker.render(screenshot_string, data_screenshot)


  qmd_text <- paste(qmd_text, screenshot_text, sep = "\n\n")

}



qmd_text <- paste(qmd_text, tab1, sep = "\n\n")




# wsi_link_string render ----

for (s in stain) {
  data_wsi_link <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    stain = s
    )

  wsi_link_text <- whisker::whisker.render(wsi_link_string, data_wsi_link)


  qmd_text <- paste(qmd_text, wsi_link_text, sep = "\n\n")

}



qmd_text <- paste(qmd_text, tab2, sep = "\n\n")




# wsi_string render ----

for (s in stain) {
  data_wsi <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    stain = s
  )

  wsi_text <- whisker::whisker.render(wsi_string, data_wsi)


  qmd_text <- paste(qmd_text, wsi_text, sep = "\n\n")

}




# diagnosis render ----

if (diagnosis) {

  data_diagnosis <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template)

  diagnosis_string <- whisker::whisker.render(diagnosis_string, data_diagnosis)


  qmd_text <- paste(qmd_text, diagnosis_string, sep = "\n\n")

}


# youtube render ----

if (use_youtube) {

  data_youtube <- list(
    youtube_link = youtube_link
    )

  youtube_string <- whisker::whisker.render(youtube_string, data_youtube)


  qmd_text <- paste(qmd_text, youtube_string, sep = "\n\n")

}

# end render ----

qmd_text <- paste(qmd_text, end_string, sep = "\n\n")


qmd_text <- gsub(pattern = "((<", replacement = "{{<", x = qmd_text, fixed = TRUE)
qmd_text <- gsub(pattern = ">))", replacement = ">}}", x = qmd_text, fixed = TRUE)

return(qmd_text)

}



# README TEXT ----

readme_text <- function(
    base_template = FALSE,
    TemplateTR = "TemplateTR",
    TemplateEN = "TemplateEN",
    template = "template",
    stain = c("HE1", "HE2"),
    diagnosis = FALSE,
    use_youtube = FALSE,
    youtube_link = "youtube_link"
) {

  # base_string ----

  base_string <- '

# {{template}}


**{{template}} for pathology atlas repositories**


'

  # head_string ----

  head_string <- '



<title>{{TemplateEN}} {{TemplateTR}}</title>
<meta name="keywords" content="{{TemplateEN}}, {{TemplateTR}}, patoloji, atlas, pathology, whole slide image">
<meta name="description" content="{{TemplateEN}} {{TemplateTR}}">





```
r language {{template}}, echo=FALSE, include=TRUE
source("./R/language.R")
output_type <- knitr::opts_knit$get("rmarkdown.pandoc.to")
```


```
asis {{TemplateTR}} TR, echo = (language == "TR")
## {{template}} - {{TemplateTR}} {#sec-{{template}} }
```


```
asis {{TemplateEN}} EN, echo = (language == "EN")
## {{template}} - {{TemplateEN}} {#sec-{{template}} }
```

'


  # screenshot_string ----

  screenshot_string <- '


```
r {{template}} screenshot {{stain}}, eval=TRUE, include=FALSE
if (!file.exists("./screenshots/thumbnail_{{template}}-{{stain}}.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/{{template}}/{{stain}}.html",
  file = "./screenshots/thumbnail_{{template}}-{{stain}}.png"
)
}
```

'

# tab1 ----

tab1 <- '

::::: panel-tabset


### WSI - Link


'

# wsi_link_string ----

wsi_link_string <- '





[https://images.patolojiatlasi.com/{{template}}/{{stain}}.html](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)





```
asis, echo = (language == "TR")

**{{TemplateTR}}**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/thumbnail_{{template}}-{{stain}}.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)
```

```
asis, echo = (language == "EN")

**{{TemplateEN}}**

[![Click for Full Screen WSI](./screenshots/thumbnail_{{template}}-{{stain}}.png){width="25%"}](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)

```

'

# tab2 ----

tab2 <- '

### WSI


'


# wsi_string ----

wsi_string <- '



```
asis, echo = ((language=="TR") & (output_type=="html"))
Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>

```





```
asis, echo = ((language == "EN") & (output_type=="html"))

See Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>

```

'



# diagnosis_string ----


diagnosis_string <-
  '

### Diagnosis


```
asis, echo = (language == "TR")


::: {.callout-tip collapse="true" appearance="default" icon="true"}
### Tanı için tıklayın

{{TemplateTR}}

:::


```


```
asis, echo = (language == "EN")


::: {.callout-tip collapse="true" appearance="default" icon="true"}
### Click for Diagnosis

{{TemplateEN}}

:::

```




'

# youtube_string ----


youtube_string <-

  '

### Video



```
asis, echo = (language == "TR")

[Video İçin Tıklayın](https://www.youtube.com/watch?v={{youtube_link}})

```


```
asis, echo = (language == "EN")

[Click for Video](https://www.youtube.com/watch?v={{youtube_link}})

```



::: {.content-visible when-format="html"}

((< video https://www.youtube.com/embed/{{youtube_link}} >))

:::

'


# end_string ----

end_string <-
  '


:::::














'

# readme_text ----

readme_text <- ''


# base render ----

if (base_template) {

  data_base <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template)

  base_string <- whisker::whisker.render(base_string, data_base)


  readme_text <- paste(readme_text, base_string, sep = "\n\n")


}



# head render ----


data_head <- list(
  TemplateTR = TemplateTR,
  TemplateEN = TemplateEN,
  template = template)

head_text <- whisker::whisker.render(head_string, data_head)


readme_text <- paste(readme_text, head_text, sep = "\n\n")



# screenshot render ----

for (s in stain) {
  data_screenshot <- list(
    template = template,
    stain = s
  )

  screenshot_text <- whisker::whisker.render(screenshot_string, data_screenshot)


  readme_text <- paste(readme_text, screenshot_text, sep = "\n\n")

}



readme_text <- paste(readme_text, tab1, sep = "\n\n")




# wsi_link_string render ----

for (s in stain) {
  data_wsi_link <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    stain = s
  )

  wsi_link_text <- whisker::whisker.render(wsi_link_string, data_wsi_link)


  readme_text <- paste(readme_text, wsi_link_text, sep = "\n\n")

}



readme_text <- paste(readme_text, tab2, sep = "\n\n")




# wsi_string render ----

for (s in stain) {
  data_wsi <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    stain = s
  )

  wsi_text <- whisker::whisker.render(wsi_string, data_wsi)


  readme_text <- paste(readme_text, wsi_text, sep = "\n\n")

}




# diagnosis render ----

if (diagnosis) {

  data_diagnosis <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template)

  diagnosis_string <- whisker::whisker.render(diagnosis_string, data_diagnosis)


  readme_text <- paste(readme_text, diagnosis_string, sep = "\n\n")

}


# youtube render ----

if (use_youtube) {

  data_youtube <- list(
    youtube_link = youtube_link
  )

  youtube_string <- whisker::whisker.render(youtube_string, data_youtube)


  readme_text <- paste(readme_text, youtube_string, sep = "\n\n")

}

# end render ----

readme_text <- paste(readme_text, end_string, sep = "\n\n")


readme_text <- gsub(pattern = "((<", replacement = "{{<", x = readme_text, fixed = TRUE)
readme_text <- gsub(pattern = ">))", replacement = ">}}", x = readme_text, fixed = TRUE)

return(readme_text)

}



#
#
# # combine ----
#
#
# # text_to_write <- qmd_text()
#
#
# text_to_write <- qmd_text(
#   base_template = TRUE,
#   TemplateTR = "deneme TR",
#   TemplateEN = "deneme EN",
#   template = "deneme",
#   stain = c("ER", "PR", "CMV"),
#   diagnosis = TRUE,
#   use_youtube = TRUE,
#   youtube_link = "deneme"
# )
#
#
# writeLines(text = text_to_write, con = "./newqmd.qmd", sep = "\n")


# for (i in 1:41) {
# writeLines(text = qmd_text(), con = paste0("./subchapters/_hacettepe_com_case_",i, ".qmd"), sep = "\n")
# }

# cat(
# paste0("{{< include ./_subchapters/_hacettepe_com_case_", 1:41, ".qmd >}}"), sep = "\n\n\n\n")


