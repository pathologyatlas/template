# template


**template for pathology atlas repositories**


```
see [make-html-WSI](https://github.com/pathologyatlas/make-html-WSI) for more information and [TODO](https://github.com/pathologyatlas/TODO) to add cases
```

```
In this README file replace the following:
TemplateEN with description of file in English
TemplateTR with description of file in Turkish
template with repository name

```


```
update html file <head>

<title>TemplateEN templateTR</title>

<meta name="keywords" content="TemplateEN, templateTR, patoloji, atlas, pathology, whole slide image">

<meta name="description" content="TemplateEN templateTR">

```



```zsh

vips dzsave HE.svs HE

```



```
update html file to match .dzi file

```


```
add to begining of qmd page

---
description: |
    TemplateEN
    TemplateTR
date: last-modified
categories: [template]
page-layout: full
bibliography: references.bib
---

```



> consider using git_push.sh script to upload files to github, since the number of generated files is huge

> after upload complete, do not forget to activate github pages for the new repository



```{r language template, echo=FALSE, include=TRUE}
source("./R/language.R")
output_type <- knitr::opts_knit$get("rmarkdown.pandoc.to")
```




```{asis, echo = (language == "TR")}
## TemplateTR {#sec-template}
```


```{asis, echo = (language == "EN")}
## TemplateEN {#sec-template}
```


```{r template screenshot, eval=TRUE, include=FALSE}
if (!file.exists("./screenshots/thumbnail_template.png")) {
webshot2::webshot(
  url = "https://images.patolojiatlasi.com/template/HE.html",
  file = "./screenshots/thumbnail_template.png"
)
}
```

```{comment, echo=FALSE, include=FALSE, eval=FALSE}
knitr::include_url(url = "https://images.patolojiatlasi.com/template/HE.html")
```

```{comment, echo=FALSE, include=FALSE, eval=FALSE}
#| label: template_screenshot
#| fig-cap: "TemplateTR"
knitr::include_graphics("./screenshots/thumbnail_template.png")
```


::: {.content-hidden when-format="html"}
TemplateTR
:::

::: {.content-visible when-format="pdf"}
TemplateTR
:::



```{asis, echo = (language == "TR")}

**templateTR**


[![Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/thumbnail_template.png){width="25%"}](https://images.patolojiatlasi.com/template/HE.html) [Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/template/HE.html)
```


```{asis, echo = ((language=="TR") & (output_type=="html"))}
Mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/template/HE.html" style="height:600px;width:100%;" data-external="1"></iframe>

```



```{comment} 
asis, echo = (language == "TR")

**templateTR**


[![İşaretlenmiş mikroskopik görüntüleri Tam Ekran Görmek İçin Resmi Tıklayın](./screenshots/thumbnail_template.png){width="25%"}](https://images.patolojiatlasi.com/template/HE_annotated.html) [İşaretlenmiş mikroskopik görüntüleri Tam Ekran Görmek İçin Resmi Tıklayın](https://images.patolojiatlasi.com/template/HE_annotated.html)
```

```{comment} 
asis, echo = ((language=="TR") & (output_type=="html"))

İşaretlenmiş mikroskopik görüntüleri inceleyin:

<iframe src="https://images.patolojiatlasi.com/template/HE_annotated.html" style="height:600px;width:100%;" data-external="1"></iframe>

```



```{comment}
asis, echo = (language == "TR")


::: {.callout-tip collapse="true" appearance="default" icon="true"}
### Tanı için tıklayın

{{TemplateTR}}

:::



```


```{asis, echo = (language == "EN")}

**templateEN**

[![Click for Full Screen WSI](./screenshots/thumbnail_template.png){width="25%"}](https://images.patolojiatlasi.com/template/HE.html) [Click for Full Screen WSI](https://images.patolojiatlasi.com/template/HE.html)


```



```{asis, echo = ((language == "EN") & (output_type=="html"))} 

See Microscopy with viewer: 

<iframe src="https://images.patolojiatlasi.com/template/HE.html" style="height:600px;width:100%;" data-external="1"></iframe>

```


```{comment}
asis, echo = (language == "EN")

**templateEN**

[![Click for Full Screen Annotated WSI](./screenshots/thumbnail_template.png){width="25%"}](https://images.patolojiatlasi.com/template/HE_annotated.html) [Click for Full Screen Annotated WSI](https://images.patolojiatlasi.com/template/HE_annotated.html)
```



```{comment}
asis, echo = ((language=="EN") & (output_type=="html"))

See Annotated Microscopy with viewer: 

<iframe src="https://images.patolojiatlasi.com/template/HE_annotated.html" style="height:600px;width:100%;" data-external="1"></iframe>

```




```{comment}
asis, echo = (language == "EN")

::: {.callout-tip collapse="true" appearance="default" icon="true"}
### Tanı için tıklayın

{{TemplateEN}}

:::



```





```{asis, echo = (language == "TR")}

[Video İçin Tıklayın](https://www.youtube.com/watch?v=)

```


```{asis, echo = (language == "EN")}

[Click for Video](https://www.youtube.com/watch?v=)

```



::: {.content-visible when-format="html"}

{{< video https://www.youtube.com/embed/ >}}

:::




