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

## {{template}}


**{{template}} for pathology atlas repositories**


'

# head_string ----

head_string <- '


```{comment}
---
description: |
    {{TemplateTR}}, {{TemplateEN}}, patoloji, atlas, pathology, whole slide image, virtual microscopy, virtual microscope, sanal mikroskop
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
## {{TemplateTR}} {#sec-{{template}} }
```


```{asis {{TemplateEN}} EN , echo = (language == "EN")}
## {{TemplateEN}} {#sec-{{template}} }
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

for (s in trimws(stain)) {
  data_screenshot <- list(
    template = template,
    stain = s
  )

  screenshot_text <- whisker::whisker.render(screenshot_string, data_screenshot)


  qmd_text <- paste(qmd_text, screenshot_text, sep = "\n\n")

}



qmd_text <- paste(qmd_text, tab1, sep = "\n\n")




# wsi_link_string render ----

for (s in trimws(stain)) {
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

for (s in trimws(stain)) {
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
    youtube_link = "youtube_link",
    end_template = FALSE
) {



## base_string ----

base_string <- '

# {{template}}


**{{template}} for pathology atlas repositories**


((< include ./_subchapters/_{{template}}.qmd >))


```
see [make-html-WSI](https://github.com/pathologyatlas/make-html-WSI) for more information and [TODO](https://github.com/pathologyatlas/TODO) to add cases
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



## head_string ----

head_string <- '

update html file heading:
<title>{{TemplateEN}} {{TemplateTR}}</title>
<meta name="keywords" content="{{TemplateEN}}, {{TemplateTR}}, patoloji, atlas, pathology, whole slide image, virtual microscopy, virtual microscope, sanal mikroskop">
<meta name="description" content="{{TemplateEN}} {{TemplateTR}}">

'



## yaml string ----


yaml_string <- paste0("
```yaml
- stainname: {{template}}-{{stain}}
  reponame: {{template}}
  titleTR: {{TemplateTR}}
  titleEN: {{TemplateEN}}
  organTR: ''
  organEN: ''
  speciality: ''
  type: published
  author:
  - Serdar Balci
  - Memorial Patoloji
  date: ", Sys.Date(), "
  url: https://images.patolojiatlasi.com/{{template}}/{{stain}}.html
  note: ''
  categoriesTR:
  - ''
  - ''
  - ''
  - patoloji
  - atlas
  - histopatoloji
  - whole slide image
  - sanal mikroskop
  categoriesEN:
  - ''
  - ''
  - ''
  - pathology
  - atlas
  - histopathology
  - whole slide image
  - virtual microscopy
  - virtual microscope
  screenshot: https://www.patolojiatlasi.com/screenshots/thumbnail_{{template}}-{{stain}}.png
  github: https:///github.com/pathologyatlas/{{template}}
  githubpage: https://pathologyatlas.github.io/{{template}}
  youtube: " , ifelse(use_youtube, paste0("https://www.youtube.com/watch?v=", youtube_link), "''"), "
```
"
)



## wsi_link_string ----

wsi_link_string <- '


[https://images.patolojiatlasi.com/{{template}}/](https://images.patolojiatlasi.com/{{template}}/)

[https://images.patolojiatlasi.com/{{template}}/{{stain}}.html](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)


**{{TemplateTR}}**

[Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)

<a href="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html"><img alt="Tam Ekran Görmek İçin Resmi Tıklayın" src ="https://www.patolojiatlasi.com/screenshots/thumbnail_{{template}}-{{stain}}.png" style="width:25%;"></a>



**{{TemplateEN}}**

[Click for Full Screen WSI](https://images.patolojiatlasi.com/{{template}}/{{stain}}.html)

<a href="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html"><img alt="Click for Full Screen WSI" src ="https://www.patolojiatlasi.com/screenshots/thumbnail_{{template}}-{{stain}}.png" style="width:25%;"></a>


'


## wsi_string ----

wsi_string <- '


Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>


See Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/{{template}}/{{stain}}.html" style="height:600px;width:100%;" data-external="1"></iframe>


'


## youtube_string ----


youtube_string <-

  '

[Video İçin Tıklayın](https://www.youtube.com/watch?v={{youtube_link}})


[Click for Video](https://www.youtube.com/watch?v={{youtube_link}})


'


## end_string ----

end_string <-
  '

<hr>

<a href="https://www.patolojiatlasi.com/"><img src ="https://www.patolojiatlasi.com/images/coverTR.png" style="width:50%;"></a>

<a href="https://www.histopathologyatlas.com/"><img src ="https://www.patolojiatlasi.com/images/coverEN.png" style="width:50%;"></a>



- Sosyal medyadan derlenen görüntülerden oluşan patoloji notları için [tıklayın](https://www.patolojinotlari.com/).

- For social media based pathology notes [click here](https://www.patolojinotlari.com/).

<a href="https://www.patolojinotlari.com/"><img src ="https://www.patolojiatlasi.com/images/patolojinotlari.com.png" style="width:50%;"></a>



<iframe width="160" height="400" src="https://leanpub.com/patolojiatlasi/embed" frameborder="0" allowtransparency="true"></iframe>



<a href="https://play.google.com/store/books/details?id=um5jEAAAQBAJ&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1"><img src="https://play.google.com/intl/en_us/badges/static/images/badges/tr_badge_web_generic.png" style="width: 250px;"></a>




<a href="https://books.apple.com/us/book/patoloji-atlas%C4%B1/id6456452218?itscg=30200&amp;itsct=books_box_badge&amp;ls=1" style="display: inline-block; overflow: hidden; border-radius: 13px; width: 250px; height: 83px;"><img src="https://tools.applemediaservices.com/api/badges/get-it-on-apple-books/badge/tr-tr?size=250x83&amp;releaseDate=1690848000" alt="Get it on Apple Books" style="border-radius: 13px; width: 250px; height: 83px;"></a>






| Atıf için (Citation)                                                                                                                                                                                                                                                                                     |
|------------------------------------------------------------------------|
| [![](https://zenodo.org/badge/452585667.svg)](https://zenodo.org/badge/latestdoi/452585667)                                                                                                                                                                                                              |
| [Open Science Framework DOI: 10.17605/OSF.IO/6W5K8](https://osf.io/6w5k8/)                                                                                                                                                                                                                               |
| [![](https://img.shields.io/github/issues/patolojiatlasi/patolojiatlasi.github.io)](https://github.com/patolojiatlasi/patolojiatlasi.github.io/issues)                                                                                                                                                   |
| [![](https://img.shields.io/github/license/patolojiatlasi/patolojiatlasi.github.io)](https://github.com/patolojiatlasi/patolojiatlasi.github.io/blob/main/LICENSE)                                                                                                                                       |
| <a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fwww.patolojiatlasi.com%2F%20@patolojinotlari%20@serdarbalci%20"><img src="https://img.shields.io/twitter/url?label=Patoloji%20Atlas%C4%B1&amp;style=social&amp;url=https%3A%2F%2Fwww.patolojiatlasi.com%2F" alt="Twitter"/></a>    |
| <a href="https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fwww.patolojinotlari.com%2F%20@patolojinotlari%20@serdarbalci%20"><img src="https://img.shields.io/twitter/url?label=Patoloji%20Notlar%C4%B1&amp;style=social&amp;url=https%3A%2F%2Fwww.patolojinotlari.com%2F" alt="Twitter"/></a> |




'


# readme_text ----

readme_text <- ''


## base render ----

if (base_template) {

  data_base <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template)

  base_string <- whisker::whisker.render(base_string, data_base)


  readme_text <- paste(readme_text, base_string, sep = "\n\n")


}



## head render ----


data_head <- list(
  TemplateTR = TemplateTR,
  TemplateEN = TemplateEN,
  template = template)

head_text <- whisker::whisker.render(head_string, data_head)


readme_text <- paste(readme_text, head_text, sep = "\n\n")


## wsi_link_string render ----

for (s in trimws(stain)) {
  data_wsi <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    stain = s
  )

  wsi_link_text <- whisker::whisker.render(wsi_link_string, data_wsi)

  wsi_text <- whisker::whisker.render(wsi_string, data_wsi)

  readme_text <- paste(readme_text, wsi_link_text, wsi_text, sep = "\n\n")

}

#
#
# ## wsi_string render ----
#
# for (s in trimws(stain)) {
#   data_wsi <- list(
#     TemplateTR = TemplateTR,
#     TemplateEN = TemplateEN,
#     template = template,
#     stain = s
#   )
#
#   wsi_text <- whisker::whisker.render(wsi_string, data_wsi)
#
#
#   readme_text <- paste(readme_text, wsi_text, sep = "\n\n")
#
# }
#


## youtube render ----

if (use_youtube) {

  data_youtube <- list(
    youtube_link = youtube_link
  )

  youtube_string <- whisker::whisker.render(youtube_string, data_youtube)


  readme_text <- paste(readme_text, youtube_string, sep = "\n\n")

}


## yaml_string render ----

for (s in trimws(stain)) {
  data_yaml <- list(
    TemplateTR = TemplateTR,
    TemplateEN = TemplateEN,
    template = template,
    stain = s,
    youtube_link = youtube_link
  )

  yaml_text <- whisker::whisker.render(yaml_string, data_yaml)


  readme_text <- paste(readme_text, yaml_text, sep = "\n\n")

}

if (!use_youtube) {
  readme_text <- gsub(pattern = "youtube: https://www.youtube.com/watch\\?v=.+", replacement = "youtube: ''", x = readme_text, perl = TRUE)
  }




## end render ----



if (end_template) {

  readme_text <- paste(readme_text, end_string, sep = "\n\n")

}




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



