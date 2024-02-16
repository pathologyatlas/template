---
title: "template"
author: Serdar Balcı
format:
  gfm:
    preview-mode: raw
  html: default
date: last-modified 
toc: true
keep-yaml: true
keep-md: true
editor: visual
bibliography: references.bib
reference-location: document
shift-heading-level-by: 1
citation:
  type: book
  container-title: "Patoloji Atlası"
#  doi: 
---









# template


**template for pathology atlas repositories**








<title>TemplateEN TemplateTR</title>
<meta name="keywords" content="TemplateEN, TemplateTR, patoloji, atlas, pathology, whole slide image">
<meta name="description" content="TemplateEN TemplateTR">





```
r language template, echo=FALSE, include=TRUE
source("./R/language.R")
output_type <- knitr::opts_knit$get("rmarkdown.pandoc.to")
```


```
asis TemplateTR TR, echo = (language == "TR")
## template - TemplateTR {#sec-template }
```


```
asis TemplateEN EN, echo = (language == "EN")
## template - TemplateEN {#sec-template }
```






```
r template screenshot HE1, eval=TRUE, include=FALSE
if (!file.exists("./screenshots/thumbnail_template-HE1.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/template/HE1.html",
  file = "./screenshots/thumbnail_template-HE1.png"
)
}
```






```
r template screenshot HE2, eval=TRUE, include=FALSE
if (!file.exists("./screenshots/thumbnail_template-HE2.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/template/HE2.html",
  file = "./screenshots/thumbnail_template-HE2.png"
)
}
```





::::: panel-tabset


### WSI - Link










[https://images.patolojiatlasi.com/template/HE1.html](https://images.patolojiatlasi.com/template/HE1.html)





```
asis, echo = (language == "TR")

**TemplateTR**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/thumbnail_template-HE1.png){width="25%"}](https://images.patolojiatlasi.com/template/HE1.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/template/HE1.html)
```

```
asis, echo = (language == "EN")

**TemplateEN**

[![Click for Full Screen WSI](./screenshots/thumbnail_template-HE1.png){width="25%"}](https://images.patolojiatlasi.com/template/HE1.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/template/HE1.html)

```









[https://images.patolojiatlasi.com/template/HE2.html](https://images.patolojiatlasi.com/template/HE2.html)





```
asis, echo = (language == "TR")

**TemplateTR**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/thumbnail_template-HE2.png){width="25%"}](https://images.patolojiatlasi.com/template/HE2.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/template/HE2.html)
```

```
asis, echo = (language == "EN")

**TemplateEN**

[![Click for Full Screen WSI](./screenshots/thumbnail_template-HE2.png){width="25%"}](https://images.patolojiatlasi.com/template/HE2.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/template/HE2.html)

```





### WSI








```
asis, echo = ((language=="TR") & (output_type=="html"))
Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/template/HE1.html" style="height:600px;width:100%;" data-external="1"></iframe>

```





```
asis, echo = ((language == "EN") & (output_type=="html"))

See Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/template/HE1.html" style="height:600px;width:100%;" data-external="1"></iframe>

```







```
asis, echo = ((language=="TR") & (output_type=="html"))
Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/template/HE2.html" style="height:600px;width:100%;" data-external="1"></iframe>

```





```
asis, echo = ((language == "EN") & (output_type=="html"))

See Microscopy with viewer:

<iframe src="https://images.patolojiatlasi.com/template/HE2.html" style="height:600px;width:100%;" data-external="1"></iframe>

```





### Diagnosis


```
asis, echo = (language == "TR")


::: {.callout-tip collapse="true" appearance="default" icon="true"}
### Tanı için tıklayın

TemplateTR

:::


```


```
asis, echo = (language == "EN")


::: {.callout-tip collapse="true" appearance="default" icon="true"}
### Click for Diagnosis

TemplateEN

:::

```








### Video



```
asis, echo = (language == "TR")

[Video İçin Tıklayın](https://www.youtube.com/watch?v=youtube_link)

```


```
asis, echo = (language == "EN")

[Click for Video](https://www.youtube.com/watch?v=youtube_link)

```



::: {.content-visible when-format="html"}




{{< video https://www.youtube.com/embed/youtube_link >}}







:::






:::::












